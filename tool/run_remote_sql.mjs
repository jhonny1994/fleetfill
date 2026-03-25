import fs from 'node:fs/promises'
import process from 'node:process'
import pg from 'pg'

const [, , sqlFilePath] = process.argv

if (!sqlFilePath) {
  console.error('Usage: node tool/run_remote_sql.mjs <sql-file>')
  process.exit(1)
}

const connectionString = process.env.SUPABASE_DB_URL

if (!connectionString) {
  console.error('SUPABASE_DB_URL is required to execute remote SQL.')
  process.exit(1)
}

const sql = await fs.readFile(sqlFilePath, 'utf8')
const client = new pg.Client({
  connectionString,
  ssl: {
    rejectUnauthorized: false,
  },
})

try {
  await client.connect()
  await client.query(sql)
  console.log(`Applied SQL from ${sqlFilePath}`)
} finally {
  await client.end().catch(() => {})
}
