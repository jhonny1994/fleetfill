export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          extensions?: Json
          operationName?: string
          query?: string
          variables?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      admin_accounts: {
        Row: {
          activated_at: string
          admin_role: Database["public"]["Enums"]["admin_role"]
          created_at: string
          deactivated_at: string | null
          deactivated_by: string | null
          invited_by: string | null
          is_active: boolean
          profile_id: string
          updated_at: string
        }
        Insert: {
          activated_at?: string
          admin_role: Database["public"]["Enums"]["admin_role"]
          created_at?: string
          deactivated_at?: string | null
          deactivated_by?: string | null
          invited_by?: string | null
          is_active?: boolean
          profile_id: string
          updated_at?: string
        }
        Update: {
          activated_at?: string
          admin_role?: Database["public"]["Enums"]["admin_role"]
          created_at?: string
          deactivated_at?: string | null
          deactivated_by?: string | null
          invited_by?: string | null
          is_active?: boolean
          profile_id?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "admin_accounts_deactivated_by_fkey"
            columns: ["deactivated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_accounts_invited_by_fkey"
            columns: ["invited_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_accounts_profile_id_fkey"
            columns: ["profile_id"]
            isOneToOne: true
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      admin_audit_logs: {
        Row: {
          action: string
          actor_id: string | null
          actor_role: Database["public"]["Enums"]["app_role"] | null
          correlation_id: string | null
          created_at: string
          id: string
          metadata: Json | null
          outcome: string
          reason: string | null
          target_id: string | null
          target_type: string
        }
        Insert: {
          action: string
          actor_id?: string | null
          actor_role?: Database["public"]["Enums"]["app_role"] | null
          correlation_id?: string | null
          created_at?: string
          id?: string
          metadata?: Json | null
          outcome: string
          reason?: string | null
          target_id?: string | null
          target_type: string
        }
        Update: {
          action?: string
          actor_id?: string | null
          actor_role?: Database["public"]["Enums"]["app_role"] | null
          correlation_id?: string | null
          created_at?: string
          id?: string
          metadata?: Json | null
          outcome?: string
          reason?: string | null
          target_id?: string | null
          target_type?: string
        }
        Relationships: [
          {
            foreignKeyName: "admin_audit_logs_actor_id_fkey"
            columns: ["actor_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      admin_invitations: {
        Row: {
          accepted_at: string | null
          accepted_by_profile_id: string | null
          created_at: string
          email: string
          expires_at: string
          id: string
          invited_by: string | null
          revoked_at: string | null
          revoked_by: string | null
          role: Database["public"]["Enums"]["admin_role"]
          status: Database["public"]["Enums"]["admin_invitation_status"]
          token_hash: string
          updated_at: string
        }
        Insert: {
          accepted_at?: string | null
          accepted_by_profile_id?: string | null
          created_at?: string
          email: string
          expires_at: string
          id?: string
          invited_by?: string | null
          revoked_at?: string | null
          revoked_by?: string | null
          role: Database["public"]["Enums"]["admin_role"]
          status?: Database["public"]["Enums"]["admin_invitation_status"]
          token_hash: string
          updated_at?: string
        }
        Update: {
          accepted_at?: string | null
          accepted_by_profile_id?: string | null
          created_at?: string
          email?: string
          expires_at?: string
          id?: string
          invited_by?: string | null
          revoked_at?: string | null
          revoked_by?: string | null
          role?: Database["public"]["Enums"]["admin_role"]
          status?: Database["public"]["Enums"]["admin_invitation_status"]
          token_hash?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "admin_invitations_accepted_by_profile_id_fkey"
            columns: ["accepted_by_profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_invitations_invited_by_fkey"
            columns: ["invited_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "admin_invitations_revoked_by_fkey"
            columns: ["revoked_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      bookings: {
        Row: {
          base_price_dzd: number
          booking_status: Database["public"]["Enums"]["booking_status"]
          cancelled_at: string | null
          carrier_fee_dzd: number
          carrier_id: string
          carrier_payout_dzd: number
          completed_at: string | null
          confirmed_at: string | null
          created_at: string
          delivered_at: string | null
          delivery_confirmed_at: string | null
          disputed_at: string | null
          id: string
          insurance_fee_dzd: number
          insurance_rate: number | null
          oneoff_trip_id: string | null
          payment_reference: string
          payment_status: Database["public"]["Enums"]["payment_status"]
          picked_up_at: string | null
          platform_fee_dzd: number
          price_per_kg_dzd: number
          route_departure_date: string | null
          route_id: string | null
          shipment_id: string
          shipper_id: string
          shipper_total_dzd: number
          tax_fee_dzd: number
          tracking_number: string
          updated_at: string
          vehicle_id: string
          volume_m3: number | null
          weight_kg: number
        }
        Insert: {
          base_price_dzd: number
          booking_status?: Database["public"]["Enums"]["booking_status"]
          cancelled_at?: string | null
          carrier_fee_dzd: number
          carrier_id: string
          carrier_payout_dzd: number
          completed_at?: string | null
          confirmed_at?: string | null
          created_at?: string
          delivered_at?: string | null
          delivery_confirmed_at?: string | null
          disputed_at?: string | null
          id?: string
          insurance_fee_dzd?: number
          insurance_rate?: number | null
          oneoff_trip_id?: string | null
          payment_reference: string
          payment_status?: Database["public"]["Enums"]["payment_status"]
          picked_up_at?: string | null
          platform_fee_dzd: number
          price_per_kg_dzd: number
          route_departure_date?: string | null
          route_id?: string | null
          shipment_id: string
          shipper_id: string
          shipper_total_dzd: number
          tax_fee_dzd?: number
          tracking_number: string
          updated_at?: string
          vehicle_id: string
          volume_m3?: number | null
          weight_kg: number
        }
        Update: {
          base_price_dzd?: number
          booking_status?: Database["public"]["Enums"]["booking_status"]
          cancelled_at?: string | null
          carrier_fee_dzd?: number
          carrier_id?: string
          carrier_payout_dzd?: number
          completed_at?: string | null
          confirmed_at?: string | null
          created_at?: string
          delivered_at?: string | null
          delivery_confirmed_at?: string | null
          disputed_at?: string | null
          id?: string
          insurance_fee_dzd?: number
          insurance_rate?: number | null
          oneoff_trip_id?: string | null
          payment_reference?: string
          payment_status?: Database["public"]["Enums"]["payment_status"]
          picked_up_at?: string | null
          platform_fee_dzd?: number
          price_per_kg_dzd?: number
          route_departure_date?: string | null
          route_id?: string | null
          shipment_id?: string
          shipper_id?: string
          shipper_total_dzd?: number
          tax_fee_dzd?: number
          tracking_number?: string
          updated_at?: string
          vehicle_id?: string
          volume_m3?: number | null
          weight_kg?: number
        }
        Relationships: [
          {
            foreignKeyName: "bookings_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "bookings_oneoff_trip_id_fkey"
            columns: ["oneoff_trip_id"]
            isOneToOne: false
            referencedRelation: "oneoff_trips"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "bookings_route_id_fkey"
            columns: ["route_id"]
            isOneToOne: false
            referencedRelation: "routes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "bookings_shipment_id_fkey"
            columns: ["shipment_id"]
            isOneToOne: true
            referencedRelation: "shipments"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "bookings_shipper_id_fkey"
            columns: ["shipper_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "bookings_vehicle_id_fkey"
            columns: ["vehicle_id"]
            isOneToOne: false
            referencedRelation: "vehicles"
            referencedColumns: ["id"]
          },
        ]
      }
      carrier_reviews: {
        Row: {
          booking_id: string
          carrier_id: string
          comment: string | null
          created_at: string
          id: string
          score: number
          shipper_id: string
        }
        Insert: {
          booking_id: string
          carrier_id: string
          comment?: string | null
          created_at?: string
          id?: string
          score: number
          shipper_id: string
        }
        Update: {
          booking_id?: string
          carrier_id?: string
          comment?: string | null
          created_at?: string
          id?: string
          score?: number
          shipper_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "carrier_reviews_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: true
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "carrier_reviews_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "carrier_reviews_shipper_id_fkey"
            columns: ["shipper_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      carrier_verification_packets: {
        Row: {
          carrier_id: string
          created_at: string
          rejection_reason: string | null
          status: Database["public"]["Enums"]["verification_status"]
          updated_at: string
        }
        Insert: {
          carrier_id: string
          created_at?: string
          rejection_reason?: string | null
          status?: Database["public"]["Enums"]["verification_status"]
          updated_at?: string
        }
        Update: {
          carrier_id?: string
          created_at?: string
          rejection_reason?: string | null
          status?: Database["public"]["Enums"]["verification_status"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "carrier_verification_packets_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: true
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      communes: {
        Row: {
          id: number
          name: string
          name_ar: string
          wilaya_id: number
        }
        Insert: {
          id: number
          name: string
          name_ar: string
          wilaya_id: number
        }
        Update: {
          id?: number
          name?: string
          name_ar?: string
          wilaya_id?: number
        }
        Relationships: [
          {
            foreignKeyName: "communes_wilaya_id_fkey"
            columns: ["wilaya_id"]
            isOneToOne: false
            referencedRelation: "wilayas"
            referencedColumns: ["id"]
          },
        ]
      }
      dispute_evidence: {
        Row: {
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          dispute_id: string
          id: string
          note: string | null
          storage_path: string
          upload_session_id: string | null
          uploaded_by: string | null
          version: number
        }
        Insert: {
          byte_size?: number | null
          checksum_sha256?: string | null
          content_type?: string | null
          created_at?: string
          dispute_id: string
          id?: string
          note?: string | null
          storage_path: string
          upload_session_id?: string | null
          uploaded_by?: string | null
          version?: number
        }
        Update: {
          byte_size?: number | null
          checksum_sha256?: string | null
          content_type?: string | null
          created_at?: string
          dispute_id?: string
          id?: string
          note?: string | null
          storage_path?: string
          upload_session_id?: string | null
          uploaded_by?: string | null
          version?: number
        }
        Relationships: [
          {
            foreignKeyName: "dispute_evidence_dispute_id_fkey"
            columns: ["dispute_id"]
            isOneToOne: false
            referencedRelation: "disputes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "dispute_evidence_upload_session_id_fkey"
            columns: ["upload_session_id"]
            isOneToOne: false
            referencedRelation: "upload_sessions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "dispute_evidence_uploaded_by_fkey"
            columns: ["uploaded_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      disputes: {
        Row: {
          booking_id: string
          created_at: string
          description: string | null
          id: string
          opened_by: string
          reason: string
          resolution: string | null
          resolution_note: string | null
          resolved_at: string | null
          resolved_by: string | null
          status: Database["public"]["Enums"]["dispute_status"]
          updated_at: string
        }
        Insert: {
          booking_id: string
          created_at?: string
          description?: string | null
          id?: string
          opened_by: string
          reason: string
          resolution?: string | null
          resolution_note?: string | null
          resolved_at?: string | null
          resolved_by?: string | null
          status?: Database["public"]["Enums"]["dispute_status"]
          updated_at?: string
        }
        Update: {
          booking_id?: string
          created_at?: string
          description?: string | null
          id?: string
          opened_by?: string
          reason?: string
          resolution?: string | null
          resolution_note?: string | null
          resolved_at?: string | null
          resolved_by?: string | null
          status?: Database["public"]["Enums"]["dispute_status"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "disputes_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: true
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "disputes_opened_by_fkey"
            columns: ["opened_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "disputes_resolved_by_fkey"
            columns: ["resolved_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      email_delivery_logs: {
        Row: {
          attempt_count: number
          booking_id: string | null
          created_at: string
          error_code: string | null
          error_message: string | null
          id: string
          last_attempt_at: string | null
          last_error_at: string | null
          locale: string
          next_retry_at: string | null
          payload_snapshot: Json | null
          profile_id: string | null
          provider: string
          provider_message_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_delivery_status"]
          subject_preview: string | null
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        Insert: {
          attempt_count?: number
          booking_id?: string | null
          created_at?: string
          error_code?: string | null
          error_message?: string | null
          id?: string
          last_attempt_at?: string | null
          last_error_at?: string | null
          locale: string
          next_retry_at?: string | null
          payload_snapshot?: Json | null
          profile_id?: string | null
          provider: string
          provider_message_id?: string | null
          recipient_email: string
          status?: Database["public"]["Enums"]["email_delivery_status"]
          subject_preview?: string | null
          template_key: string
          template_language_code?: string | null
          updated_at?: string
        }
        Update: {
          attempt_count?: number
          booking_id?: string | null
          created_at?: string
          error_code?: string | null
          error_message?: string | null
          id?: string
          last_attempt_at?: string | null
          last_error_at?: string | null
          locale?: string
          next_retry_at?: string | null
          payload_snapshot?: Json | null
          profile_id?: string | null
          provider?: string
          provider_message_id?: string | null
          recipient_email?: string
          status?: Database["public"]["Enums"]["email_delivery_status"]
          subject_preview?: string | null
          template_key?: string
          template_language_code?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "email_delivery_logs_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: false
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "email_delivery_logs_profile_id_fkey"
            columns: ["profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      email_outbox_jobs: {
        Row: {
          attempt_count: number
          available_at: string
          booking_id: string | null
          created_at: string
          dedupe_key: string
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locale: string
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          payload_snapshot: Json | null
          priority: string
          profile_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_outbox_status"]
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        Insert: {
          attempt_count?: number
          available_at: string
          booking_id?: string | null
          created_at?: string
          dedupe_key: string
          event_key: string
          id?: string
          last_error_code?: string | null
          last_error_message?: string | null
          locale: string
          locked_at?: string | null
          locked_by?: string | null
          max_attempts?: number
          payload_snapshot?: Json | null
          priority: string
          profile_id?: string | null
          recipient_email: string
          status?: Database["public"]["Enums"]["email_outbox_status"]
          template_key: string
          template_language_code?: string | null
          updated_at?: string
        }
        Update: {
          attempt_count?: number
          available_at?: string
          booking_id?: string | null
          created_at?: string
          dedupe_key?: string
          event_key?: string
          id?: string
          last_error_code?: string | null
          last_error_message?: string | null
          locale?: string
          locked_at?: string | null
          locked_by?: string | null
          max_attempts?: number
          payload_snapshot?: Json | null
          priority?: string
          profile_id?: string | null
          recipient_email?: string
          status?: Database["public"]["Enums"]["email_outbox_status"]
          template_key?: string
          template_language_code?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "email_outbox_jobs_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: false
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "email_outbox_jobs_profile_id_fkey"
            columns: ["profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      email_templates: {
        Row: {
          created_at: string
          description: string | null
          html_template: string
          id: string
          is_enabled: boolean
          language_code: string
          sample_payload: Json
          subject_template: string
          template_key: string
          text_template: string
          updated_at: string
          updated_by: string | null
        }
        Insert: {
          created_at?: string
          description?: string | null
          html_template: string
          id?: string
          is_enabled?: boolean
          language_code: string
          sample_payload?: Json
          subject_template: string
          template_key: string
          text_template: string
          updated_at?: string
          updated_by?: string | null
        }
        Update: {
          created_at?: string
          description?: string | null
          html_template?: string
          id?: string
          is_enabled?: boolean
          language_code?: string
          sample_payload?: Json
          subject_template?: string
          template_key?: string
          text_template?: string
          updated_at?: string
          updated_by?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "email_templates_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      financial_ledger_entries: {
        Row: {
          actor_type: string
          amount_dzd: number
          booking_id: string
          created_at: string
          created_by: string | null
          direction: Database["public"]["Enums"]["ledger_direction"]
          entry_type: string
          id: string
          notes: string | null
          occurred_at: string
          reference: string | null
        }
        Insert: {
          actor_type: string
          amount_dzd: number
          booking_id: string
          created_at?: string
          created_by?: string | null
          direction: Database["public"]["Enums"]["ledger_direction"]
          entry_type: string
          id?: string
          notes?: string | null
          occurred_at: string
          reference?: string | null
        }
        Update: {
          actor_type?: string
          amount_dzd?: number
          booking_id?: string
          created_at?: string
          created_by?: string | null
          direction?: Database["public"]["Enums"]["ledger_direction"]
          entry_type?: string
          id?: string
          notes?: string | null
          occurred_at?: string
          reference?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "financial_ledger_entries_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: false
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "financial_ledger_entries_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      generated_documents: {
        Row: {
          available_at: string | null
          booking_id: string | null
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          document_type: string
          failure_reason: string | null
          generated_by: string | null
          id: string
          locked_at: string | null
          locked_by: string | null
          status: string
          storage_path: string
          version: number
        }
        Insert: {
          available_at?: string | null
          booking_id?: string | null
          byte_size?: number | null
          checksum_sha256?: string | null
          content_type?: string | null
          created_at?: string
          document_type: string
          failure_reason?: string | null
          generated_by?: string | null
          id?: string
          locked_at?: string | null
          locked_by?: string | null
          status?: string
          storage_path: string
          version?: number
        }
        Update: {
          available_at?: string | null
          booking_id?: string | null
          byte_size?: number | null
          checksum_sha256?: string | null
          content_type?: string | null
          created_at?: string
          document_type?: string
          failure_reason?: string | null
          generated_by?: string | null
          id?: string
          locked_at?: string | null
          locked_by?: string | null
          status?: string
          storage_path?: string
          version?: number
        }
        Relationships: [
          {
            foreignKeyName: "generated_documents_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: false
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "generated_documents_generated_by_fkey"
            columns: ["generated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      notifications: {
        Row: {
          body: string
          created_at: string
          data: Json | null
          id: string
          is_read: boolean
          profile_id: string
          read_at: string | null
          title: string
          type: string
        }
        Insert: {
          body: string
          created_at?: string
          data?: Json | null
          id?: string
          is_read?: boolean
          profile_id: string
          read_at?: string | null
          title: string
          type: string
        }
        Update: {
          body?: string
          created_at?: string
          data?: Json | null
          id?: string
          is_read?: boolean
          profile_id?: string
          read_at?: string | null
          title?: string
          type?: string
        }
        Relationships: [
          {
            foreignKeyName: "notifications_profile_id_fkey"
            columns: ["profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      oneoff_trips: {
        Row: {
          carrier_id: string
          created_at: string
          departure_at: string
          destination_commune_id: number
          id: string
          is_active: boolean
          origin_commune_id: number
          price_per_kg_dzd: number
          total_capacity_kg: number
          total_capacity_volume_m3: number | null
          updated_at: string
          vehicle_id: string
        }
        Insert: {
          carrier_id: string
          created_at?: string
          departure_at: string
          destination_commune_id: number
          id?: string
          is_active: boolean
          origin_commune_id: number
          price_per_kg_dzd: number
          total_capacity_kg: number
          total_capacity_volume_m3?: number | null
          updated_at?: string
          vehicle_id: string
        }
        Update: {
          carrier_id?: string
          created_at?: string
          departure_at?: string
          destination_commune_id?: number
          id?: string
          is_active?: boolean
          origin_commune_id?: number
          price_per_kg_dzd?: number
          total_capacity_kg?: number
          total_capacity_volume_m3?: number | null
          updated_at?: string
          vehicle_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "oneoff_trips_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "oneoff_trips_destination_commune_id_fkey"
            columns: ["destination_commune_id"]
            isOneToOne: false
            referencedRelation: "communes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "oneoff_trips_origin_commune_id_fkey"
            columns: ["origin_commune_id"]
            isOneToOne: false
            referencedRelation: "communes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "oneoff_trips_vehicle_id_fkey"
            columns: ["vehicle_id"]
            isOneToOne: false
            referencedRelation: "vehicles"
            referencedColumns: ["id"]
          },
        ]
      }
      payment_proofs: {
        Row: {
          booking_id: string
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          decision_note: string | null
          id: string
          payment_rail: Database["public"]["Enums"]["payment_rail"]
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          submitted_amount_dzd: number
          submitted_at: string
          submitted_reference: string | null
          upload_session_id: string | null
          uploaded_by: string | null
          verified_amount_dzd: number | null
          verified_reference: string | null
          version: number
        }
        Insert: {
          booking_id: string
          byte_size?: number | null
          checksum_sha256?: string | null
          content_type?: string | null
          created_at?: string
          decision_note?: string | null
          id?: string
          payment_rail: Database["public"]["Enums"]["payment_rail"]
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          submitted_amount_dzd: number
          submitted_at: string
          submitted_reference?: string | null
          upload_session_id?: string | null
          uploaded_by?: string | null
          verified_amount_dzd?: number | null
          verified_reference?: string | null
          version?: number
        }
        Update: {
          booking_id?: string
          byte_size?: number | null
          checksum_sha256?: string | null
          content_type?: string | null
          created_at?: string
          decision_note?: string | null
          id?: string
          payment_rail?: Database["public"]["Enums"]["payment_rail"]
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["verification_status"]
          storage_path?: string
          submitted_amount_dzd?: number
          submitted_at?: string
          submitted_reference?: string | null
          upload_session_id?: string | null
          uploaded_by?: string | null
          verified_amount_dzd?: number | null
          verified_reference?: string | null
          version?: number
        }
        Relationships: [
          {
            foreignKeyName: "payment_proofs_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: false
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "payment_proofs_reviewed_by_fkey"
            columns: ["reviewed_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "payment_proofs_upload_session_id_fkey"
            columns: ["upload_session_id"]
            isOneToOne: false
            referencedRelation: "upload_sessions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "payment_proofs_uploaded_by_fkey"
            columns: ["uploaded_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      payout_accounts: {
        Row: {
          account_holder_name: string
          account_identifier: string
          account_type: Database["public"]["Enums"]["payment_rail"]
          bank_or_ccp_name: string | null
          carrier_id: string
          created_at: string
          id: string
          is_active: boolean
          is_verified: boolean
          updated_at: string
          verified_at: string | null
        }
        Insert: {
          account_holder_name: string
          account_identifier: string
          account_type: Database["public"]["Enums"]["payment_rail"]
          bank_or_ccp_name?: string | null
          carrier_id: string
          created_at?: string
          id?: string
          is_active?: boolean
          is_verified?: boolean
          updated_at?: string
          verified_at?: string | null
        }
        Update: {
          account_holder_name?: string
          account_identifier?: string
          account_type?: Database["public"]["Enums"]["payment_rail"]
          bank_or_ccp_name?: string | null
          carrier_id?: string
          created_at?: string
          id?: string
          is_active?: boolean
          is_verified?: boolean
          updated_at?: string
          verified_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "payout_accounts_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      payout_requests: {
        Row: {
          booking_id: string
          cancelled_at: string | null
          carrier_id: string
          created_at: string
          fulfilled_at: string | null
          id: string
          note: string | null
          requested_at: string
          status: Database["public"]["Enums"]["payout_request_status"]
          updated_at: string
        }
        Insert: {
          booking_id: string
          cancelled_at?: string | null
          carrier_id: string
          created_at?: string
          fulfilled_at?: string | null
          id?: string
          note?: string | null
          requested_at?: string
          status?: Database["public"]["Enums"]["payout_request_status"]
          updated_at?: string
        }
        Update: {
          booking_id?: string
          cancelled_at?: string | null
          carrier_id?: string
          created_at?: string
          fulfilled_at?: string | null
          id?: string
          note?: string | null
          requested_at?: string
          status?: Database["public"]["Enums"]["payout_request_status"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "payout_requests_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: true
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "payout_requests_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      payouts: {
        Row: {
          amount_dzd: number
          booking_id: string
          carrier_id: string
          created_at: string
          external_reference: string | null
          failure_reason: string | null
          id: string
          payout_account_id: string
          payout_account_snapshot: Json
          processed_at: string | null
          processed_by: string | null
          status: Database["public"]["Enums"]["transfer_status"]
          updated_at: string
        }
        Insert: {
          amount_dzd: number
          booking_id: string
          carrier_id: string
          created_at?: string
          external_reference?: string | null
          failure_reason?: string | null
          id?: string
          payout_account_id: string
          payout_account_snapshot: Json
          processed_at?: string | null
          processed_by?: string | null
          status?: Database["public"]["Enums"]["transfer_status"]
          updated_at?: string
        }
        Update: {
          amount_dzd?: number
          booking_id?: string
          carrier_id?: string
          created_at?: string
          external_reference?: string | null
          failure_reason?: string | null
          id?: string
          payout_account_id?: string
          payout_account_snapshot?: Json
          processed_at?: string | null
          processed_by?: string | null
          status?: Database["public"]["Enums"]["transfer_status"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "payouts_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: true
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "payouts_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "payouts_payout_account_id_fkey"
            columns: ["payout_account_id"]
            isOneToOne: false
            referencedRelation: "payout_accounts"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "payouts_processed_by_fkey"
            columns: ["processed_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      platform_payment_accounts: {
        Row: {
          account_holder_name: string | null
          account_identifier: string
          created_at: string
          display_name: string
          environment: Database["public"]["Enums"]["platform_environment"]
          id: string
          instructions_text: string | null
          is_active: boolean
          payment_rail: Database["public"]["Enums"]["payment_rail"]
          updated_at: string
        }
        Insert: {
          account_holder_name?: string | null
          account_identifier: string
          created_at?: string
          display_name: string
          environment: Database["public"]["Enums"]["platform_environment"]
          id?: string
          instructions_text?: string | null
          is_active?: boolean
          payment_rail: Database["public"]["Enums"]["payment_rail"]
          updated_at?: string
        }
        Update: {
          account_holder_name?: string | null
          account_identifier?: string
          created_at?: string
          display_name?: string
          environment?: Database["public"]["Enums"]["platform_environment"]
          id?: string
          instructions_text?: string | null
          is_active?: boolean
          payment_rail?: Database["public"]["Enums"]["payment_rail"]
          updated_at?: string
        }
        Relationships: []
      }
      platform_settings: {
        Row: {
          description: string | null
          is_public: boolean
          key: string
          updated_at: string
          updated_by: string | null
          value: Json
        }
        Insert: {
          description?: string | null
          is_public?: boolean
          key: string
          updated_at?: string
          updated_by?: string | null
          value: Json
        }
        Update: {
          description?: string | null
          is_public?: boolean
          key?: string
          updated_at?: string
          updated_by?: string | null
          value?: Json
        }
        Relationships: [
          {
            foreignKeyName: "platform_settings_updated_by_fkey"
            columns: ["updated_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      profiles: {
        Row: {
          avatar_url: string | null
          company_name: string | null
          created_at: string
          email: string
          full_name: string | null
          id: string
          is_active: boolean
          phone_number: string | null
          preferred_locale: string
          rating_average: number | null
          rating_count: number
          role: Database["public"]["Enums"]["app_role"]
          updated_at: string
        }
        Insert: {
          avatar_url?: string | null
          company_name?: string | null
          created_at?: string
          email: string
          full_name?: string | null
          id: string
          is_active?: boolean
          phone_number?: string | null
          preferred_locale?: string
          rating_average?: number | null
          rating_count?: number
          role: Database["public"]["Enums"]["app_role"]
          updated_at?: string
        }
        Update: {
          avatar_url?: string | null
          company_name?: string | null
          created_at?: string
          email?: string
          full_name?: string | null
          id?: string
          is_active?: boolean
          phone_number?: string | null
          preferred_locale?: string
          rating_average?: number | null
          rating_count?: number
          role?: Database["public"]["Enums"]["app_role"]
          updated_at?: string
        }
        Relationships: []
      }
      push_outbox_jobs: {
        Row: {
          attempt_count: number
          available_at: string
          body: string
          created_at: string
          dedupe_key: string
          delivered_at: string | null
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          notification_id: string
          payload_snapshot: Json | null
          profile_id: string
          provider: string | null
          provider_message_id: string | null
          status: string
          title: string
          updated_at: string
        }
        Insert: {
          attempt_count?: number
          available_at?: string
          body: string
          created_at?: string
          dedupe_key: string
          delivered_at?: string | null
          event_key: string
          id?: string
          last_error_code?: string | null
          last_error_message?: string | null
          locked_at?: string | null
          locked_by?: string | null
          max_attempts?: number
          notification_id: string
          payload_snapshot?: Json | null
          profile_id: string
          provider?: string | null
          provider_message_id?: string | null
          status?: string
          title: string
          updated_at?: string
        }
        Update: {
          attempt_count?: number
          available_at?: string
          body?: string
          created_at?: string
          dedupe_key?: string
          delivered_at?: string | null
          event_key?: string
          id?: string
          last_error_code?: string | null
          last_error_message?: string | null
          locked_at?: string | null
          locked_by?: string | null
          max_attempts?: number
          notification_id?: string
          payload_snapshot?: Json | null
          profile_id?: string
          provider?: string | null
          provider_message_id?: string | null
          status?: string
          title?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "push_outbox_jobs_notification_id_fkey"
            columns: ["notification_id"]
            isOneToOne: true
            referencedRelation: "notifications"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "push_outbox_jobs_profile_id_fkey"
            columns: ["profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      refunds: {
        Row: {
          amount_dzd: number
          booking_id: string
          created_at: string
          dispute_id: string | null
          external_reference: string | null
          id: string
          processed_at: string | null
          processed_by: string | null
          reason: string
          status: Database["public"]["Enums"]["transfer_status"]
          updated_at: string
        }
        Insert: {
          amount_dzd: number
          booking_id: string
          created_at?: string
          dispute_id?: string | null
          external_reference?: string | null
          id?: string
          processed_at?: string | null
          processed_by?: string | null
          reason: string
          status?: Database["public"]["Enums"]["transfer_status"]
          updated_at?: string
        }
        Update: {
          amount_dzd?: number
          booking_id?: string
          created_at?: string
          dispute_id?: string | null
          external_reference?: string | null
          id?: string
          processed_at?: string | null
          processed_by?: string | null
          reason?: string
          status?: Database["public"]["Enums"]["transfer_status"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "refunds_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: false
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "refunds_dispute_id_fkey"
            columns: ["dispute_id"]
            isOneToOne: false
            referencedRelation: "disputes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "refunds_processed_by_fkey"
            columns: ["processed_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      route_departure_instances: {
        Row: {
          created_at: string
          departure_date: string
          id: string
          remaining_capacity_kg: number
          remaining_volume_m3: number | null
          reserved_capacity_kg: number
          reserved_volume_m3: number | null
          route_id: string
          status: string
          total_capacity_kg: number
          total_capacity_volume_m3: number | null
          updated_at: string
          vehicle_id: string
        }
        Insert: {
          created_at?: string
          departure_date: string
          id?: string
          remaining_capacity_kg: number
          remaining_volume_m3?: number | null
          reserved_capacity_kg?: number
          reserved_volume_m3?: number | null
          route_id: string
          status: string
          total_capacity_kg: number
          total_capacity_volume_m3?: number | null
          updated_at?: string
          vehicle_id: string
        }
        Update: {
          created_at?: string
          departure_date?: string
          id?: string
          remaining_capacity_kg?: number
          remaining_volume_m3?: number | null
          reserved_capacity_kg?: number
          reserved_volume_m3?: number | null
          route_id?: string
          status?: string
          total_capacity_kg?: number
          total_capacity_volume_m3?: number | null
          updated_at?: string
          vehicle_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "route_departure_instances_route_id_fkey"
            columns: ["route_id"]
            isOneToOne: false
            referencedRelation: "routes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "route_departure_instances_vehicle_id_fkey"
            columns: ["vehicle_id"]
            isOneToOne: false
            referencedRelation: "vehicles"
            referencedColumns: ["id"]
          },
        ]
      }
      route_revisions: {
        Row: {
          created_at: string
          created_by: string | null
          default_departure_time: string
          destination_commune_id: number | null
          effective_from: string
          id: string
          origin_commune_id: number | null
          price_per_kg_dzd: number
          recurring_days_of_week: number[]
          route_id: string
          total_capacity_kg: number
          total_capacity_volume_m3: number | null
          vehicle_id: string
        }
        Insert: {
          created_at?: string
          created_by?: string | null
          default_departure_time: string
          destination_commune_id?: number | null
          effective_from: string
          id?: string
          origin_commune_id?: number | null
          price_per_kg_dzd: number
          recurring_days_of_week: number[]
          route_id: string
          total_capacity_kg: number
          total_capacity_volume_m3?: number | null
          vehicle_id: string
        }
        Update: {
          created_at?: string
          created_by?: string | null
          default_departure_time?: string
          destination_commune_id?: number | null
          effective_from?: string
          id?: string
          origin_commune_id?: number | null
          price_per_kg_dzd?: number
          recurring_days_of_week?: number[]
          route_id?: string
          total_capacity_kg?: number
          total_capacity_volume_m3?: number | null
          vehicle_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "route_revisions_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "route_revisions_destination_commune_id_fkey"
            columns: ["destination_commune_id"]
            isOneToOne: false
            referencedRelation: "communes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "route_revisions_origin_commune_id_fkey"
            columns: ["origin_commune_id"]
            isOneToOne: false
            referencedRelation: "communes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "route_revisions_route_id_fkey"
            columns: ["route_id"]
            isOneToOne: false
            referencedRelation: "routes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "route_revisions_vehicle_id_fkey"
            columns: ["vehicle_id"]
            isOneToOne: false
            referencedRelation: "vehicles"
            referencedColumns: ["id"]
          },
        ]
      }
      routes: {
        Row: {
          carrier_id: string
          created_at: string
          default_departure_time: string
          destination_commune_id: number
          effective_from: string
          id: string
          is_active: boolean
          origin_commune_id: number
          price_per_kg_dzd: number
          recurring_days_of_week: number[]
          total_capacity_kg: number
          total_capacity_volume_m3: number | null
          updated_at: string
          vehicle_id: string
        }
        Insert: {
          carrier_id: string
          created_at?: string
          default_departure_time: string
          destination_commune_id: number
          effective_from: string
          id?: string
          is_active: boolean
          origin_commune_id: number
          price_per_kg_dzd: number
          recurring_days_of_week: number[]
          total_capacity_kg: number
          total_capacity_volume_m3?: number | null
          updated_at?: string
          vehicle_id: string
        }
        Update: {
          carrier_id?: string
          created_at?: string
          default_departure_time?: string
          destination_commune_id?: number
          effective_from?: string
          id?: string
          is_active?: boolean
          origin_commune_id?: number
          price_per_kg_dzd?: number
          recurring_days_of_week?: number[]
          total_capacity_kg?: number
          total_capacity_volume_m3?: number | null
          updated_at?: string
          vehicle_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "routes_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "routes_destination_commune_id_fkey"
            columns: ["destination_commune_id"]
            isOneToOne: false
            referencedRelation: "communes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "routes_origin_commune_id_fkey"
            columns: ["origin_commune_id"]
            isOneToOne: false
            referencedRelation: "communes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "routes_vehicle_id_fkey"
            columns: ["vehicle_id"]
            isOneToOne: false
            referencedRelation: "vehicles"
            referencedColumns: ["id"]
          },
        ]
      }
      security_abuse_events: {
        Row: {
          action_key: string
          actor_id: string | null
          created_at: string
          id: string
          metadata: Json | null
          reason: string
        }
        Insert: {
          action_key: string
          actor_id?: string | null
          created_at?: string
          id?: string
          metadata?: Json | null
          reason: string
        }
        Update: {
          action_key?: string
          actor_id?: string | null
          created_at?: string
          id?: string
          metadata?: Json | null
          reason?: string
        }
        Relationships: [
          {
            foreignKeyName: "security_abuse_events_actor_id_fkey"
            columns: ["actor_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      security_rate_limits: {
        Row: {
          action_key: string
          actor_id: string
          created_at: string
          hit_count: number
          id: string
          updated_at: string
          window_started_at: string
        }
        Insert: {
          action_key: string
          actor_id: string
          created_at?: string
          hit_count?: number
          id?: string
          updated_at?: string
          window_started_at: string
        }
        Update: {
          action_key?: string
          actor_id?: string
          created_at?: string
          hit_count?: number
          id?: string
          updated_at?: string
          window_started_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "security_rate_limits_actor_id_fkey"
            columns: ["actor_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      shipments: {
        Row: {
          created_at: string
          description: string | null
          destination_commune_id: number
          id: string
          origin_commune_id: number
          shipper_id: string
          status: Database["public"]["Enums"]["shipment_status"]
          total_volume_m3: number | null
          total_weight_kg: number
          updated_at: string
        }
        Insert: {
          created_at?: string
          description?: string | null
          destination_commune_id: number
          id?: string
          origin_commune_id: number
          shipper_id: string
          status?: Database["public"]["Enums"]["shipment_status"]
          total_volume_m3?: number | null
          total_weight_kg: number
          updated_at?: string
        }
        Update: {
          created_at?: string
          description?: string | null
          destination_commune_id?: number
          id?: string
          origin_commune_id?: number
          shipper_id?: string
          status?: Database["public"]["Enums"]["shipment_status"]
          total_volume_m3?: number | null
          total_weight_kg?: number
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "shipments_destination_commune_id_fkey"
            columns: ["destination_commune_id"]
            isOneToOne: false
            referencedRelation: "communes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "shipments_origin_commune_id_fkey"
            columns: ["origin_commune_id"]
            isOneToOne: false
            referencedRelation: "communes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "shipments_shipper_id_fkey"
            columns: ["shipper_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      support_messages: {
        Row: {
          body: string
          created_at: string
          id: string
          request_id: string
          sender_profile_id: string | null
          sender_type: Database["public"]["Enums"]["support_message_sender_type"]
        }
        Insert: {
          body: string
          created_at?: string
          id?: string
          request_id: string
          sender_profile_id?: string | null
          sender_type: Database["public"]["Enums"]["support_message_sender_type"]
        }
        Update: {
          body?: string
          created_at?: string
          id?: string
          request_id?: string
          sender_profile_id?: string | null
          sender_type?: Database["public"]["Enums"]["support_message_sender_type"]
        }
        Relationships: [
          {
            foreignKeyName: "support_messages_request_id_fkey"
            columns: ["request_id"]
            isOneToOne: false
            referencedRelation: "support_requests"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "support_messages_sender_profile_id_fkey"
            columns: ["sender_profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      support_requests: {
        Row: {
          admin_last_read_at: string | null
          assigned_admin_id: string | null
          booking_id: string | null
          created_at: string
          created_by: string
          dispute_id: string | null
          id: string
          last_message_at: string
          last_message_preview: string | null
          last_message_sender_type: Database["public"]["Enums"]["support_message_sender_type"]
          payment_proof_id: string | null
          priority: Database["public"]["Enums"]["support_request_priority"]
          requester_role: Database["public"]["Enums"]["app_role"]
          shipment_id: string | null
          status: Database["public"]["Enums"]["support_request_status"]
          subject: string
          updated_at: string
          user_last_read_at: string | null
        }
        Insert: {
          admin_last_read_at?: string | null
          assigned_admin_id?: string | null
          booking_id?: string | null
          created_at?: string
          created_by: string
          dispute_id?: string | null
          id?: string
          last_message_at?: string
          last_message_preview?: string | null
          last_message_sender_type?: Database["public"]["Enums"]["support_message_sender_type"]
          payment_proof_id?: string | null
          priority?: Database["public"]["Enums"]["support_request_priority"]
          requester_role: Database["public"]["Enums"]["app_role"]
          shipment_id?: string | null
          status?: Database["public"]["Enums"]["support_request_status"]
          subject: string
          updated_at?: string
          user_last_read_at?: string | null
        }
        Update: {
          admin_last_read_at?: string | null
          assigned_admin_id?: string | null
          booking_id?: string | null
          created_at?: string
          created_by?: string
          dispute_id?: string | null
          id?: string
          last_message_at?: string
          last_message_preview?: string | null
          last_message_sender_type?: Database["public"]["Enums"]["support_message_sender_type"]
          payment_proof_id?: string | null
          priority?: Database["public"]["Enums"]["support_request_priority"]
          requester_role?: Database["public"]["Enums"]["app_role"]
          shipment_id?: string | null
          status?: Database["public"]["Enums"]["support_request_status"]
          subject?: string
          updated_at?: string
          user_last_read_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "support_requests_assigned_admin_id_fkey"
            columns: ["assigned_admin_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "support_requests_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: false
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "support_requests_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "support_requests_dispute_id_fkey"
            columns: ["dispute_id"]
            isOneToOne: false
            referencedRelation: "disputes"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "support_requests_payment_proof_id_fkey"
            columns: ["payment_proof_id"]
            isOneToOne: false
            referencedRelation: "payment_proofs"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "support_requests_shipment_id_fkey"
            columns: ["shipment_id"]
            isOneToOne: false
            referencedRelation: "shipments"
            referencedColumns: ["id"]
          },
        ]
      }
      tracking_events: {
        Row: {
          booking_id: string
          created_at: string
          created_by: string | null
          event_type: string
          id: string
          note: string | null
          recorded_at: string
          visibility: Database["public"]["Enums"]["tracking_event_visibility"]
        }
        Insert: {
          booking_id: string
          created_at?: string
          created_by?: string | null
          event_type: string
          id?: string
          note?: string | null
          recorded_at: string
          visibility: Database["public"]["Enums"]["tracking_event_visibility"]
        }
        Update: {
          booking_id?: string
          created_at?: string
          created_by?: string | null
          event_type?: string
          id?: string
          note?: string | null
          recorded_at?: string
          visibility?: Database["public"]["Enums"]["tracking_event_visibility"]
        }
        Relationships: [
          {
            foreignKeyName: "tracking_events_booking_id_fkey"
            columns: ["booking_id"]
            isOneToOne: false
            referencedRelation: "bookings"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "tracking_events_created_by_fkey"
            columns: ["created_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      upload_sessions: {
        Row: {
          bucket_id: string
          byte_size: number
          checksum_sha256: string | null
          content_type: string
          created_at: string
          document_type: string | null
          entity_id: string
          entity_type: string
          expires_at: string
          finalized_at: string | null
          id: string
          object_path: string
          profile_id: string
          status: Database["public"]["Enums"]["upload_session_status"]
          updated_at: string
        }
        Insert: {
          bucket_id: string
          byte_size: number
          checksum_sha256?: string | null
          content_type: string
          created_at?: string
          document_type?: string | null
          entity_id: string
          entity_type: string
          expires_at: string
          finalized_at?: string | null
          id?: string
          object_path: string
          profile_id: string
          status?: Database["public"]["Enums"]["upload_session_status"]
          updated_at?: string
        }
        Update: {
          bucket_id?: string
          byte_size?: number
          checksum_sha256?: string | null
          content_type?: string
          created_at?: string
          document_type?: string | null
          entity_id?: string
          entity_type?: string
          expires_at?: string
          finalized_at?: string | null
          id?: string
          object_path?: string
          profile_id?: string
          status?: Database["public"]["Enums"]["upload_session_status"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "upload_sessions_profile_id_fkey"
            columns: ["profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      user_devices: {
        Row: {
          created_at: string
          id: string
          last_seen_at: string | null
          locale: string | null
          platform: string
          profile_id: string
          push_token: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          last_seen_at?: string | null
          locale?: string | null
          platform: string
          profile_id: string
          push_token: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          last_seen_at?: string | null
          locale?: string | null
          platform?: string
          profile_id?: string
          push_token?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "user_devices_profile_id_fkey"
            columns: ["profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      vehicles: {
        Row: {
          capacity_volume_m3: number | null
          capacity_weight_kg: number
          carrier_id: string
          created_at: string
          id: string
          plate_number: string
          updated_at: string
          vehicle_type: string
          verification_rejection_reason: string | null
          verification_status: Database["public"]["Enums"]["verification_status"]
        }
        Insert: {
          capacity_volume_m3?: number | null
          capacity_weight_kg: number
          carrier_id: string
          created_at?: string
          id?: string
          plate_number: string
          updated_at?: string
          vehicle_type: string
          verification_rejection_reason?: string | null
          verification_status?: Database["public"]["Enums"]["verification_status"]
        }
        Update: {
          capacity_volume_m3?: number | null
          capacity_weight_kg?: number
          carrier_id?: string
          created_at?: string
          id?: string
          plate_number?: string
          updated_at?: string
          vehicle_type?: string
          verification_rejection_reason?: string | null
          verification_status?: Database["public"]["Enums"]["verification_status"]
        }
        Relationships: [
          {
            foreignKeyName: "vehicles_carrier_id_fkey"
            columns: ["carrier_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      verification_documents: {
        Row: {
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          document_type: string
          entity_id: string
          entity_type: Database["public"]["Enums"]["verification_document_entity_type"]
          expires_at: string | null
          id: string
          owner_profile_id: string
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          updated_at: string
          upload_session_id: string | null
          uploaded_by: string | null
          version: number
        }
        Insert: {
          byte_size?: number | null
          checksum_sha256?: string | null
          content_type?: string | null
          created_at?: string
          document_type: string
          entity_id: string
          entity_type: Database["public"]["Enums"]["verification_document_entity_type"]
          expires_at?: string | null
          id?: string
          owner_profile_id: string
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          updated_at?: string
          upload_session_id?: string | null
          uploaded_by?: string | null
          version?: number
        }
        Update: {
          byte_size?: number | null
          checksum_sha256?: string | null
          content_type?: string | null
          created_at?: string
          document_type?: string
          entity_id?: string
          entity_type?: Database["public"]["Enums"]["verification_document_entity_type"]
          expires_at?: string | null
          id?: string
          owner_profile_id?: string
          rejection_reason?: string | null
          reviewed_at?: string | null
          reviewed_by?: string | null
          status?: Database["public"]["Enums"]["verification_status"]
          storage_path?: string
          updated_at?: string
          upload_session_id?: string | null
          uploaded_by?: string | null
          version?: number
        }
        Relationships: [
          {
            foreignKeyName: "verification_documents_owner_profile_id_fkey"
            columns: ["owner_profile_id"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "verification_documents_reviewed_by_fkey"
            columns: ["reviewed_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "verification_documents_upload_session_id_fkey"
            columns: ["upload_session_id"]
            isOneToOne: false
            referencedRelation: "upload_sessions"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "verification_documents_uploaded_by_fkey"
            columns: ["uploaded_by"]
            isOneToOne: false
            referencedRelation: "profiles"
            referencedColumns: ["id"]
          },
        ]
      }
      wilayas: {
        Row: {
          id: number
          name: string
          name_ar: string
        }
        Insert: {
          id: number
          name: string
          name_ar: string
        }
        Update: {
          id?: number
          name?: string
          name_ar?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      accept_admin_invitation: {
        Args: { p_full_name?: string; p_phone_number?: string; p_token: string }
        Returns: {
          activated_at: string
          admin_role: Database["public"]["Enums"]["admin_role"]
          created_at: string
          deactivated_at: string | null
          deactivated_by: string | null
          invited_by: string | null
          is_active: boolean
          profile_id: string
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "admin_accounts"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      active_super_admin_count: { Args: never; Returns: number }
      admin_approve_payment_proof: {
        Args: {
          p_decision_note?: string
          p_payment_proof_id: string
          p_verified_amount_dzd: number
          p_verified_reference?: string
        }
        Returns: {
          booking_id: string
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          decision_note: string | null
          id: string
          payment_rail: Database["public"]["Enums"]["payment_rail"]
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          submitted_amount_dzd: number
          submitted_at: string
          submitted_reference: string | null
          upload_session_id: string | null
          uploaded_by: string | null
          verified_amount_dzd: number | null
          verified_reference: string | null
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "payment_proofs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_approve_verification_packet: {
        Args: { p_carrier_id: string }
        Returns: {
          action: string
          outcome: string
          target_id: string
        }[]
      }
      admin_assign_support_request: {
        Args: { p_assigned_admin_id?: string; p_request_id: string }
        Returns: {
          admin_last_read_at: string | null
          assigned_admin_id: string | null
          booking_id: string | null
          created_at: string
          created_by: string
          dispute_id: string | null
          id: string
          last_message_at: string
          last_message_preview: string | null
          last_message_sender_type: Database["public"]["Enums"]["support_message_sender_type"]
          payment_proof_id: string | null
          priority: Database["public"]["Enums"]["support_request_priority"]
          requester_role: Database["public"]["Enums"]["app_role"]
          shipment_id: string | null
          status: Database["public"]["Enums"]["support_request_status"]
          subject: string
          updated_at: string
          user_last_read_at: string | null
        }
        SetofOptions: {
          from: "*"
          to: "support_requests"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_get_operational_summary: { Args: never; Returns: Json }
      admin_reject_payment_proof: {
        Args: {
          p_decision_note?: string
          p_payment_proof_id: string
          p_rejection_reason: string
        }
        Returns: {
          booking_id: string
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          decision_note: string | null
          id: string
          payment_rail: Database["public"]["Enums"]["payment_rail"]
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          submitted_amount_dzd: number
          submitted_at: string
          submitted_reference: string | null
          upload_session_id: string | null
          uploaded_by: string | null
          verified_amount_dzd: number | null
          verified_reference: string | null
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "payment_proofs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_release_payout: {
        Args: {
          p_booking_id: string
          p_external_reference?: string
          p_note?: string
        }
        Returns: {
          amount_dzd: number
          booking_id: string
          carrier_id: string
          created_at: string
          external_reference: string | null
          failure_reason: string | null
          id: string
          payout_account_id: string
          payout_account_snapshot: Json
          processed_at: string | null
          processed_by: string | null
          status: Database["public"]["Enums"]["transfer_status"]
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "payouts"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_resolve_dispute_complete: {
        Args: { p_dispute_id: string; p_resolution_note?: string }
        Returns: {
          booking_id: string
          created_at: string
          description: string | null
          id: string
          opened_by: string
          reason: string
          resolution: string | null
          resolution_note: string | null
          resolved_at: string | null
          resolved_by: string | null
          status: Database["public"]["Enums"]["dispute_status"]
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "disputes"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_resolve_dispute_refund: {
        Args: {
          p_dispute_id: string
          p_external_reference?: string
          p_refund_amount_dzd: number
          p_refund_reason: string
          p_resolution_note?: string
        }
        Returns: {
          booking_id: string
          created_at: string
          description: string | null
          id: string
          opened_by: string
          reason: string
          resolution: string | null
          resolution_note: string | null
          resolved_at: string | null
          resolved_by: string | null
          status: Database["public"]["Enums"]["dispute_status"]
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "disputes"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_retry_dead_letter_email_job: {
        Args: { p_job_id: string }
        Returns: {
          attempt_count: number
          available_at: string
          booking_id: string | null
          created_at: string
          dedupe_key: string
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locale: string
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          payload_snapshot: Json | null
          priority: string
          profile_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_outbox_status"]
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "email_outbox_jobs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_retry_email_delivery: {
        Args: { p_delivery_log_id: string }
        Returns: {
          attempt_count: number
          available_at: string
          booking_id: string | null
          created_at: string
          dedupe_key: string
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locale: string
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          payload_snapshot: Json | null
          priority: string
          profile_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_outbox_status"]
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "email_outbox_jobs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_review_verification_document: {
        Args: {
          p_document_id: string
          p_reason?: string
          p_status: Database["public"]["Enums"]["verification_status"]
        }
        Returns: {
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          document_type: string
          entity_id: string
          entity_type: Database["public"]["Enums"]["verification_document_entity_type"]
          expires_at: string | null
          id: string
          owner_profile_id: string
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          updated_at: string
          upload_session_id: string | null
          uploaded_by: string | null
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "verification_documents"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_set_admin_account_active: {
        Args: { p_is_active: boolean; p_profile_id: string; p_reason?: string }
        Returns: {
          activated_at: string
          admin_role: Database["public"]["Enums"]["admin_role"]
          created_at: string
          deactivated_at: string | null
          deactivated_by: string | null
          invited_by: string | null
          is_active: boolean
          profile_id: string
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "admin_accounts"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_set_profile_active: {
        Args: { p_is_active: boolean; p_profile_id: string; p_reason?: string }
        Returns: {
          avatar_url: string | null
          company_name: string | null
          created_at: string
          email: string
          full_name: string | null
          id: string
          is_active: boolean
          phone_number: string | null
          preferred_locale: string
          rating_average: number | null
          rating_count: number
          role: Database["public"]["Enums"]["app_role"]
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "profiles"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_set_support_request_status: {
        Args: {
          p_priority?: Database["public"]["Enums"]["support_request_priority"]
          p_request_id: string
          p_status: Database["public"]["Enums"]["support_request_status"]
        }
        Returns: {
          admin_last_read_at: string | null
          assigned_admin_id: string | null
          booking_id: string | null
          created_at: string
          created_by: string
          dispute_id: string | null
          id: string
          last_message_at: string
          last_message_preview: string | null
          last_message_sender_type: Database["public"]["Enums"]["support_message_sender_type"]
          payment_proof_id: string | null
          priority: Database["public"]["Enums"]["support_request_priority"]
          requester_role: Database["public"]["Enums"]["app_role"]
          shipment_id: string | null
          status: Database["public"]["Enums"]["support_request_status"]
          subject: string
          updated_at: string
          user_last_read_at: string | null
        }
        SetofOptions: {
          from: "*"
          to: "support_requests"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_update_admin_role: {
        Args: {
          p_profile_id: string
          p_reason?: string
          p_role: Database["public"]["Enums"]["admin_role"]
        }
        Returns: {
          activated_at: string
          admin_role: Database["public"]["Enums"]["admin_role"]
          created_at: string
          deactivated_at: string | null
          deactivated_by: string | null
          invited_by: string | null
          is_active: boolean
          profile_id: string
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "admin_accounts"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      admin_upsert_platform_setting: {
        Args: {
          p_description?: string
          p_is_public?: boolean
          p_key: string
          p_value: Json
        }
        Returns: {
          description: string | null
          is_public: boolean
          key: string
          updated_at: string
          updated_by: string | null
          value: Json
        }
        SetofOptions: {
          from: "*"
          to: "platform_settings"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      append_tracking_event: {
        Args: {
          p_booking_id: string
          p_created_by?: string
          p_event_type: string
          p_note?: string
          p_visibility: Database["public"]["Enums"]["tracking_event_visibility"]
        }
        Returns: {
          booking_id: string
          created_at: string
          created_by: string | null
          event_type: string
          id: string
          note: string | null
          recorded_at: string
          visibility: Database["public"]["Enums"]["tracking_event_visibility"]
        }
        SetofOptions: {
          from: "*"
          to: "tracking_events"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      assert_active_carrier_access: { Args: never; Returns: string }
      assert_carrier_vehicle_access: {
        Args: { p_require_verified?: boolean; p_vehicle_id: string }
        Returns: undefined
      }
      assert_rate_limit: {
        Args: {
          p_action_key: string
          p_limit: number
          p_window_seconds: number
        }
        Returns: undefined
      }
      assert_rate_limit_for_actor: {
        Args: {
          p_action_key: string
          p_actor_id: string
          p_limit: number
          p_window_seconds: number
        }
        Returns: undefined
      }
      assert_verified_carrier_access: { Args: never; Returns: string }
      authorize_private_file_access: {
        Args: { p_bucket_id: string; p_object_path: string }
        Returns: boolean
      }
      authorize_private_file_access_for_user: {
        Args: { p_actor_id: string; p_bucket_id: string; p_object_path: string }
        Returns: boolean
      }
      auto_complete_delivered_bookings: { Args: never; Returns: number }
      booking_is_visible_to_current_user: {
        Args: { p_booking_id: string }
        Returns: boolean
      }
      booking_owned_by_current_shipper: {
        Args: { p_booking_id: string }
        Returns: boolean
      }
      booking_payout_request_block_reason: {
        Args: { p_booking: Database["public"]["Tables"]["bookings"]["Row"] }
        Returns: string
      }
      booking_status_transition_allowed: {
        Args: {
          p_new: Database["public"]["Enums"]["booking_status"]
          p_old: Database["public"]["Enums"]["booking_status"]
        }
        Returns: boolean
      }
      bootstrap_first_super_admin: {
        Args: {
          p_full_name?: string
          p_phone_number?: string
          p_profile_id: string
        }
        Returns: {
          activated_at: string
          admin_role: Database["public"]["Enums"]["admin_role"]
          created_at: string
          deactivated_at: string | null
          deactivated_by: string | null
          invited_by: string | null
          is_active: boolean
          profile_id: string
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "admin_accounts"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      build_upload_object_path: {
        Args: {
          p_bucket_id: string
          p_document_type: string
          p_entity_id: string
          p_entity_type: string
          p_file_extension: string
          p_session_id?: string
          p_version: number
        }
        Returns: string
      }
      can_upload_storage_object: {
        Args: { p_bucket_id: string; p_object_path: string }
        Returns: boolean
      }
      carrier_record_booking_milestone: {
        Args: { p_booking_id: string; p_milestone: string; p_note?: string }
        Returns: {
          base_price_dzd: number
          booking_status: Database["public"]["Enums"]["booking_status"]
          cancelled_at: string | null
          carrier_fee_dzd: number
          carrier_id: string
          carrier_payout_dzd: number
          completed_at: string | null
          confirmed_at: string | null
          created_at: string
          delivered_at: string | null
          delivery_confirmed_at: string | null
          disputed_at: string | null
          id: string
          insurance_fee_dzd: number
          insurance_rate: number | null
          oneoff_trip_id: string | null
          payment_reference: string
          payment_status: Database["public"]["Enums"]["payment_status"]
          picked_up_at: string | null
          platform_fee_dzd: number
          price_per_kg_dzd: number
          route_departure_date: string | null
          route_id: string | null
          shipment_id: string
          shipper_id: string
          shipper_total_dzd: number
          tax_fee_dzd: number
          tracking_number: string
          updated_at: string
          vehicle_id: string
          volume_m3: number | null
          weight_kg: number
        }
        SetofOptions: {
          from: "*"
          to: "bookings"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      carrier_request_payout: {
        Args: { p_booking_id: string; p_note?: string }
        Returns: {
          booking_id: string
          cancelled_at: string | null
          carrier_id: string
          created_at: string
          fulfilled_at: string | null
          id: string
          note: string | null
          requested_at: string
          status: Database["public"]["Enums"]["payout_request_status"]
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "payout_requests"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      claim_email_outbox_jobs: {
        Args: { p_batch_size?: number; p_worker_id: string }
        Returns: {
          attempt_count: number
          available_at: string
          booking_id: string | null
          created_at: string
          dedupe_key: string
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locale: string
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          payload_snapshot: Json | null
          priority: string
          profile_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_outbox_status"]
          template_key: string
          template_language_code: string | null
          updated_at: string
        }[]
        SetofOptions: {
          from: "*"
          to: "email_outbox_jobs"
          isOneToOne: false
          isSetofReturn: true
        }
      }
      claim_generated_document_jobs: {
        Args: { p_batch_size?: number; p_worker_id: string }
        Returns: {
          available_at: string | null
          booking_id: string | null
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          document_type: string
          failure_reason: string | null
          generated_by: string | null
          id: string
          locked_at: string | null
          locked_by: string | null
          status: string
          storage_path: string
          version: number
        }[]
        SetofOptions: {
          from: "*"
          to: "generated_documents"
          isOneToOne: false
          isSetofReturn: true
        }
      }
      claim_push_outbox_jobs: {
        Args: { p_batch_size?: number; p_worker_id: string }
        Returns: {
          attempt_count: number
          available_at: string
          body: string
          created_at: string
          dedupe_key: string
          delivered_at: string | null
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          notification_id: string
          payload_snapshot: Json | null
          profile_id: string
          provider: string | null
          provider_message_id: string | null
          status: string
          title: string
          updated_at: string
        }[]
        SetofOptions: {
          from: "*"
          to: "push_outbox_jobs"
          isOneToOne: false
          isSetofReturn: true
        }
      }
      complete_email_outbox_job: {
        Args: {
          p_job_id: string
          p_provider: string
          p_provider_message_id?: string
          p_subject_preview?: string
          p_template_language_code?: string
        }
        Returns: {
          attempt_count: number
          available_at: string
          booking_id: string | null
          created_at: string
          dedupe_key: string
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locale: string
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          payload_snapshot: Json | null
          priority: string
          profile_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_outbox_status"]
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "email_outbox_jobs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      complete_generated_document_processing: {
        Args: {
          p_byte_size: number
          p_checksum_sha256: string
          p_content_type: string
          p_document_id: string
        }
        Returns: {
          available_at: string | null
          booking_id: string | null
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          document_type: string
          failure_reason: string | null
          generated_by: string | null
          id: string
          locked_at: string | null
          locked_by: string | null
          status: string
          storage_path: string
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "generated_documents"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      complete_push_outbox_job: {
        Args: {
          p_error_code?: string
          p_error_message?: string
          p_job_id: string
          p_provider?: string
          p_provider_message_id?: string
          p_status?: string
        }
        Returns: {
          attempt_count: number
          available_at: string
          body: string
          created_at: string
          dedupe_key: string
          delivered_at: string | null
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          notification_id: string
          payload_snapshot: Json | null
          profile_id: string
          provider: string | null
          provider_message_id: string | null
          status: string
          title: string
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "push_outbox_jobs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      configure_scheduled_automation: {
        Args: { internal_automation_token: string; project_url: string }
        Returns: undefined
      }
      consume_rate_limit: {
        Args: {
          p_action_key: string
          p_limit: number
          p_window_seconds: number
        }
        Returns: boolean
      }
      consume_rate_limit_for_actor: {
        Args: {
          p_action_key: string
          p_actor_id: string
          p_limit: number
          p_window_seconds: number
        }
        Returns: boolean
      }
      create_admin_invitation: {
        Args: {
          p_email: string
          p_expires_in_hours?: number
          p_role: Database["public"]["Enums"]["admin_role"]
        }
        Returns: Json
      }
      create_booking_from_search_result: {
        Args: {
          p_departure_date?: string
          p_idempotency_key?: string
          p_include_insurance?: boolean
          p_shipment_id: string
          p_source_id: string
          p_source_type: string
        }
        Returns: {
          base_price_dzd: number
          booking_status: Database["public"]["Enums"]["booking_status"]
          cancelled_at: string | null
          carrier_fee_dzd: number
          carrier_id: string
          carrier_payout_dzd: number
          completed_at: string | null
          confirmed_at: string | null
          created_at: string
          delivered_at: string | null
          delivery_confirmed_at: string | null
          disputed_at: string | null
          id: string
          insurance_fee_dzd: number
          insurance_rate: number | null
          oneoff_trip_id: string | null
          payment_reference: string
          payment_status: Database["public"]["Enums"]["payment_status"]
          picked_up_at: string | null
          platform_fee_dzd: number
          price_per_kg_dzd: number
          route_departure_date: string | null
          route_id: string | null
          shipment_id: string
          shipper_id: string
          shipper_total_dzd: number
          tax_fee_dzd: number
          tracking_number: string
          updated_at: string
          vehicle_id: string
          volume_m3: number | null
          weight_kg: number
        }
        SetofOptions: {
          from: "*"
          to: "bookings"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      create_carrier_route: {
        Args: {
          p_default_departure_time: string
          p_destination_commune_id: number
          p_effective_from: string
          p_is_active: boolean
          p_origin_commune_id: number
          p_price_per_kg_dzd: number
          p_recurring_days_of_week: number[]
          p_total_capacity_kg: number
          p_total_capacity_volume_m3: number
          p_vehicle_id: string
        }
        Returns: {
          carrier_id: string
          created_at: string
          default_departure_time: string
          destination_commune_id: number
          effective_from: string
          id: string
          is_active: boolean
          origin_commune_id: number
          price_per_kg_dzd: number
          recurring_days_of_week: number[]
          total_capacity_kg: number
          total_capacity_volume_m3: number | null
          updated_at: string
          vehicle_id: string
        }
        SetofOptions: {
          from: "*"
          to: "routes"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      create_dispute_from_delivery: {
        Args: { p_booking_id: string; p_description?: string; p_reason: string }
        Returns: {
          booking_id: string
          created_at: string
          description: string | null
          id: string
          opened_by: string
          reason: string
          resolution: string | null
          resolution_note: string | null
          resolved_at: string | null
          resolved_by: string | null
          status: Database["public"]["Enums"]["dispute_status"]
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "disputes"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      create_generated_document_record: {
        Args: {
          p_booking_id: string
          p_document_type: string
          p_storage_path: string
        }
        Returns: {
          available_at: string | null
          booking_id: string | null
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          document_type: string
          failure_reason: string | null
          generated_by: string | null
          id: string
          locked_at: string | null
          locked_by: string | null
          status: string
          storage_path: string
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "generated_documents"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      create_oneoff_trip: {
        Args: {
          p_departure_at: string
          p_destination_commune_id: number
          p_is_active: boolean
          p_origin_commune_id: number
          p_price_per_kg_dzd: number
          p_total_capacity_kg: number
          p_total_capacity_volume_m3: number
          p_vehicle_id: string
        }
        Returns: {
          carrier_id: string
          created_at: string
          departure_at: string
          destination_commune_id: number
          id: string
          is_active: boolean
          origin_commune_id: number
          price_per_kg_dzd: number
          total_capacity_kg: number
          total_capacity_volume_m3: number | null
          updated_at: string
          vehicle_id: string
        }
        SetofOptions: {
          from: "*"
          to: "oneoff_trips"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      create_support_request: {
        Args: {
          p_booking_id?: string
          p_dispute_id?: string
          p_locale?: string
          p_message: string
          p_payment_proof_id?: string
          p_shipment_id?: string
          p_subject: string
        }
        Returns: {
          admin_last_read_at: string | null
          assigned_admin_id: string | null
          booking_id: string | null
          created_at: string
          created_by: string
          dispute_id: string | null
          id: string
          last_message_at: string
          last_message_preview: string | null
          last_message_sender_type: Database["public"]["Enums"]["support_message_sender_type"]
          payment_proof_id: string | null
          priority: Database["public"]["Enums"]["support_request_priority"]
          requester_role: Database["public"]["Enums"]["app_role"]
          shipment_id: string | null
          status: Database["public"]["Enums"]["support_request_status"]
          subject: string
          updated_at: string
          user_last_read_at: string | null
        }
        SetofOptions: {
          from: "*"
          to: "support_requests"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      create_upload_session: {
        Args: {
          p_byte_size: number
          p_checksum_sha256?: string
          p_content_type: string
          p_document_type: string
          p_entity_id: string
          p_entity_type: string
          p_file_extension: string
          p_upload_kind: string
        }
        Returns: {
          bucket_id: string
          expires_at: string
          max_file_size_bytes: number
          object_path: string
          upload_session_id: string
        }[]
      }
      current_admin_email_resend_enabled: { Args: never; Returns: boolean }
      current_admin_role: {
        Args: never
        Returns: Database["public"]["Enums"]["admin_role"]
      }
      current_delivery_review_grace_window_hours: {
        Args: never
        Returns: number
      }
      current_effective_verification_documents: {
        Args: {
          p_entity_id?: string
          p_entity_type?: Database["public"]["Enums"]["verification_document_entity_type"]
          p_owner_profile_id: string
        }
        Returns: {
          byte_size: number
          checksum_sha256: string
          content_type: string
          created_at: string
          document_type: string
          entity_id: string
          entity_type: Database["public"]["Enums"]["verification_document_entity_type"]
          expires_at: string
          id: string
          owner_profile_id: string
          rejection_reason: string
          reviewed_at: string
          reviewed_by: string
          status: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          updated_at: string
          upload_session_id: string
          uploaded_by: string
          version: number
        }[]
      }
      current_payment_resubmission_deadline_hours: {
        Args: never
        Returns: number
      }
      current_payout_request_grace_window_hours: {
        Args: never
        Returns: number
      }
      current_user_id: { Args: never; Returns: string }
      current_user_role: {
        Args: never
        Returns: Database["public"]["Enums"]["app_role"]
      }
      enqueue_transactional_email: {
        Args: {
          p_booking_id?: string
          p_dedupe_key?: string
          p_event_key: string
          p_locale?: string
          p_payload_snapshot?: Json
          p_priority?: string
          p_profile_id: string
          p_recipient_email: string
          p_template_key?: string
        }
        Returns: {
          attempt_count: number
          available_at: string
          booking_id: string | null
          created_at: string
          dedupe_key: string
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locale: string
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          payload_snapshot: Json | null
          priority: string
          profile_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_outbox_status"]
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "email_outbox_jobs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      ensure_admin_profile: {
        Args: {
          p_email: string
          p_full_name?: string
          p_phone_number?: string
          p_profile_id: string
        }
        Returns: {
          avatar_url: string | null
          company_name: string | null
          created_at: string
          email: string
          full_name: string | null
          id: string
          is_active: boolean
          phone_number: string | null
          preferred_locale: string
          rating_average: number | null
          rating_count: number
          role: Database["public"]["Enums"]["app_role"]
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "profiles"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      expire_admin_invitations: { Args: never; Returns: number }
      expire_payment_resubmission_deadlines: { Args: never; Returns: number }
      fail_generated_document_processing: {
        Args: { p_document_id: string; p_failure_reason?: string }
        Returns: {
          available_at: string | null
          booking_id: string | null
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          document_type: string
          failure_reason: string | null
          generated_by: string | null
          id: string
          locked_at: string | null
          locked_by: string | null
          status: string
          storage_path: string
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "generated_documents"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      finalize_dispute_evidence: {
        Args: { p_note?: string; p_upload_session_id: string }
        Returns: {
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          dispute_id: string
          id: string
          note: string | null
          storage_path: string
          upload_session_id: string | null
          uploaded_by: string | null
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "dispute_evidence"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      finalize_payment_proof: {
        Args: {
          p_submitted_amount_dzd: number
          p_submitted_reference?: string
          p_upload_session_id: string
        }
        Returns: {
          booking_id: string
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          decision_note: string | null
          id: string
          payment_rail: Database["public"]["Enums"]["payment_rail"]
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          submitted_amount_dzd: number
          submitted_at: string
          submitted_reference: string | null
          upload_session_id: string | null
          uploaded_by: string | null
          verified_amount_dzd: number | null
          verified_reference: string | null
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "payment_proofs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      finalize_verification_document: {
        Args: { p_upload_session_id: string }
        Returns: {
          byte_size: number | null
          checksum_sha256: string | null
          content_type: string | null
          created_at: string
          document_type: string
          entity_id: string
          entity_type: Database["public"]["Enums"]["verification_document_entity_type"]
          expires_at: string | null
          id: string
          owner_profile_id: string
          rejection_reason: string | null
          reviewed_at: string | null
          reviewed_by: string | null
          status: Database["public"]["Enums"]["verification_status"]
          storage_path: string
          updated_at: string
          upload_session_id: string | null
          uploaded_by: string | null
          version: number
        }
        SetofOptions: {
          from: "*"
          to: "verification_documents"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      get_booking_payout_request_context: {
        Args: { p_booking_id: string }
        Returns: Json
      }
      get_client_settings: { Args: never; Returns: Json }
      get_profile_preferred_locale: {
        Args: { p_profile_id: string }
        Returns: string
      }
      get_public_carrier_profile: {
        Args: { p_carrier_id: string }
        Returns: Json
      }
      is_active_admin_profile: {
        Args: { p_profile_id: string }
        Returns: boolean
      }
      is_active_carrier: { Args: { p_profile_id?: string }; Returns: boolean }
      is_admin: { Args: never; Returns: boolean }
      is_service_role: { Args: never; Returns: boolean }
      is_super_admin: { Args: never; Returns: boolean }
      is_trusted_operation: { Args: never; Returns: boolean }
      is_verified_carrier: { Args: { p_profile_id?: string }; Returns: boolean }
      mark_notification_read: {
        Args: { p_notification_id: string }
        Returns: {
          body: string
          created_at: string
          data: Json | null
          id: string
          is_read: boolean
          profile_id: string
          read_at: string | null
          title: string
          type: string
        }
        SetofOptions: {
          from: "*"
          to: "notifications"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      mark_support_request_read: {
        Args: { p_request_id: string }
        Returns: {
          admin_last_read_at: string | null
          assigned_admin_id: string | null
          booking_id: string | null
          created_at: string
          created_by: string
          dispute_id: string | null
          id: string
          last_message_at: string
          last_message_preview: string | null
          last_message_sender_type: Database["public"]["Enums"]["support_message_sender_type"]
          payment_proof_id: string | null
          priority: Database["public"]["Enums"]["support_request_priority"]
          requester_role: Database["public"]["Enums"]["app_role"]
          shipment_id: string | null
          status: Database["public"]["Enums"]["support_request_status"]
          subject: string
          updated_at: string
          user_last_read_at: string | null
        }
        SetofOptions: {
          from: "*"
          to: "support_requests"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      normalize_plate_number: { Args: { p_value: string }; Returns: string }
      normalize_reference_value: { Args: { p_value: string }; Returns: string }
      normalize_supported_locale: {
        Args: { p_locale: string }
        Returns: string
      }
      payment_status_transition_allowed: {
        Args: {
          p_new: Database["public"]["Enums"]["payment_status"]
          p_old: Database["public"]["Enums"]["payment_status"]
        }
        Returns: boolean
      }
      record_abuse_event: {
        Args: { p_action_key: string; p_metadata?: Json; p_reason: string }
        Returns: undefined
      }
      record_email_dispatch_failure: {
        Args: {
          p_error_code?: string
          p_error_message?: string
          p_job_id: string
          p_provider: string
          p_status: Database["public"]["Enums"]["email_delivery_status"]
          p_subject_preview?: string
          p_template_language_code?: string
        }
        Returns: {
          attempt_count: number
          booking_id: string | null
          created_at: string
          error_code: string | null
          error_message: string | null
          id: string
          last_attempt_at: string | null
          last_error_at: string | null
          locale: string
          next_retry_at: string | null
          payload_snapshot: Json | null
          profile_id: string | null
          provider: string
          provider_message_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_delivery_status"]
          subject_preview: string | null
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "email_delivery_logs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      record_email_provider_event: {
        Args: {
          p_error_code?: string
          p_error_message?: string
          p_provider_message_id: string
          p_status: Database["public"]["Enums"]["email_delivery_status"]
        }
        Returns: {
          attempt_count: number
          booking_id: string | null
          created_at: string
          error_code: string | null
          error_message: string | null
          id: string
          last_attempt_at: string | null
          last_error_at: string | null
          locale: string
          next_retry_at: string | null
          payload_snapshot: Json | null
          profile_id: string | null
          provider: string
          provider_message_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_delivery_status"]
          subject_preview: string | null
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "email_delivery_logs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      record_payout_ledger_entry: {
        Args: {
          p_amount_dzd: number
          p_booking_id: string
          p_notes?: string
          p_reference?: string
        }
        Returns: {
          actor_type: string
          amount_dzd: number
          booking_id: string
          created_at: string
          created_by: string | null
          direction: Database["public"]["Enums"]["ledger_direction"]
          entry_type: string
          id: string
          notes: string | null
          occurred_at: string
          reference: string | null
        }
        SetofOptions: {
          from: "*"
          to: "financial_ledger_entries"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      record_refund_ledger_entry: {
        Args: {
          p_amount_dzd: number
          p_booking_id: string
          p_notes?: string
          p_reference?: string
        }
        Returns: {
          actor_type: string
          amount_dzd: number
          booking_id: string
          created_at: string
          created_by: string | null
          direction: Database["public"]["Enums"]["ledger_direction"]
          entry_type: string
          id: string
          notes: string | null
          occurred_at: string
          reference: string | null
        }
        SetofOptions: {
          from: "*"
          to: "financial_ledger_entries"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      recover_stale_email_outbox_jobs: {
        Args: { p_lock_age_seconds?: number }
        Returns: number
      }
      recover_stale_generated_document_jobs: {
        Args: { p_lock_age_seconds?: number }
        Returns: number
      }
      recover_stale_push_outbox_jobs: {
        Args: { p_lock_age_seconds?: number }
        Returns: number
      }
      refresh_carrier_rating_aggregates: {
        Args: { p_carrier_id: string }
        Returns: undefined
      }
      refresh_carrier_verification_packet_status: {
        Args: { p_carrier_id: string }
        Returns: Database["public"]["Enums"]["verification_status"]
      }
      refresh_vehicle_verification_status: {
        Args: { p_owner_profile_id: string; p_vehicle_id: string }
        Returns: Database["public"]["Enums"]["verification_status"]
      }
      register_user_device: {
        Args: { p_locale?: string; p_platform: string; p_push_token: string }
        Returns: {
          created_at: string
          id: string
          last_seen_at: string | null
          locale: string | null
          platform: string
          profile_id: string
          push_token: string
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "user_devices"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      release_retryable_email_job: {
        Args: {
          p_error_code: string
          p_error_message: string
          p_job_id: string
          p_retry_delay_seconds?: number
        }
        Returns: {
          attempt_count: number
          available_at: string
          booking_id: string | null
          created_at: string
          dedupe_key: string
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locale: string
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          payload_snapshot: Json | null
          priority: string
          profile_id: string | null
          recipient_email: string
          status: Database["public"]["Enums"]["email_outbox_status"]
          template_key: string
          template_language_code: string | null
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "email_outbox_jobs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      release_retryable_push_job: {
        Args: {
          p_error_code?: string
          p_error_message?: string
          p_job_id: string
          p_retry_delay_seconds?: number
        }
        Returns: {
          attempt_count: number
          available_at: string
          body: string
          created_at: string
          dedupe_key: string
          delivered_at: string | null
          event_key: string
          id: string
          last_error_code: string | null
          last_error_message: string | null
          locked_at: string | null
          locked_by: string | null
          max_attempts: number
          notification_id: string
          payload_snapshot: Json | null
          profile_id: string
          provider: string | null
          provider_message_id: string | null
          status: string
          title: string
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "push_outbox_jobs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      reply_to_support_request: {
        Args: { p_message: string; p_request_id: string }
        Returns: {
          body: string
          created_at: string
          id: string
          request_id: string
          sender_profile_id: string | null
          sender_type: Database["public"]["Enums"]["support_message_sender_type"]
        }
        SetofOptions: {
          from: "*"
          to: "support_messages"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      require_recent_admin_step_up: { Args: never; Returns: undefined }
      required_verification_documents_complete: {
        Args: { p_owner_profile_id: string }
        Returns: boolean
      }
      revoke_admin_invitation: {
        Args: { p_invitation_id: string; p_reason?: string }
        Returns: {
          accepted_at: string | null
          accepted_by_profile_id: string | null
          created_at: string
          email: string
          expires_at: string
          id: string
          invited_by: string | null
          revoked_at: string | null
          revoked_by: string | null
          role: Database["public"]["Enums"]["admin_role"]
          status: Database["public"]["Enums"]["admin_invitation_status"]
          token_hash: string
          updated_at: string
        }
        SetofOptions: {
          from: "*"
          to: "admin_invitations"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      scheduled_automation_status: {
        Args: never
        Returns: {
          active: boolean
          jobname: string
          schedule: string
        }[]
      }
      search_exact_lane_capacity: {
        Args: {
          p_destination_commune_id: number
          p_limit?: number
          p_offset?: number
          p_origin_commune_id: number
          p_requested_date: string
          p_sort?: string
          p_total_volume_m3?: number
          p_total_weight_kg: number
        }
        Returns: Json
      }
      shipment_is_visible_to_current_user: {
        Args: { p_shipment_id: string }
        Returns: boolean
      }
      shipper_cancel_pending_booking: {
        Args: { p_booking_id: string; p_note?: string }
        Returns: {
          base_price_dzd: number
          booking_status: Database["public"]["Enums"]["booking_status"]
          cancelled_at: string | null
          carrier_fee_dzd: number
          carrier_id: string
          carrier_payout_dzd: number
          completed_at: string | null
          confirmed_at: string | null
          created_at: string
          delivered_at: string | null
          delivery_confirmed_at: string | null
          disputed_at: string | null
          id: string
          insurance_fee_dzd: number
          insurance_rate: number | null
          oneoff_trip_id: string | null
          payment_reference: string
          payment_status: Database["public"]["Enums"]["payment_status"]
          picked_up_at: string | null
          platform_fee_dzd: number
          price_per_kg_dzd: number
          route_departure_date: string | null
          route_id: string | null
          shipment_id: string
          shipper_id: string
          shipper_total_dzd: number
          tax_fee_dzd: number
          tracking_number: string
          updated_at: string
          vehicle_id: string
          volume_m3: number | null
          weight_kg: number
        }
        SetofOptions: {
          from: "*"
          to: "bookings"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      shipper_confirm_delivery: {
        Args: { p_booking_id: string; p_note?: string }
        Returns: {
          base_price_dzd: number
          booking_status: Database["public"]["Enums"]["booking_status"]
          cancelled_at: string | null
          carrier_fee_dzd: number
          carrier_id: string
          carrier_payout_dzd: number
          completed_at: string | null
          confirmed_at: string | null
          created_at: string
          delivered_at: string | null
          delivery_confirmed_at: string | null
          disputed_at: string | null
          id: string
          insurance_fee_dzd: number
          insurance_rate: number | null
          oneoff_trip_id: string | null
          payment_reference: string
          payment_status: Database["public"]["Enums"]["payment_status"]
          picked_up_at: string | null
          platform_fee_dzd: number
          price_per_kg_dzd: number
          route_departure_date: string | null
          route_id: string | null
          shipment_id: string
          shipper_id: string
          shipper_total_dzd: number
          tax_fee_dzd: number
          tracking_number: string
          updated_at: string
          vehicle_id: string
          volume_m3: number | null
          weight_kg: number
        }
        SetofOptions: {
          from: "*"
          to: "bookings"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      submit_carrier_review: {
        Args: { p_booking_id: string; p_comment?: string; p_score: number }
        Returns: {
          booking_id: string
          carrier_id: string
          comment: string | null
          created_at: string
          id: string
          score: number
          shipper_id: string
        }
        SetofOptions: {
          from: "*"
          to: "carrier_reviews"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      update_oneoff_trip: {
        Args: {
          p_departure_at: string
          p_destination_commune_id: number
          p_is_active: boolean
          p_origin_commune_id: number
          p_price_per_kg_dzd: number
          p_total_capacity_kg: number
          p_total_capacity_volume_m3: number
          p_trip_id: string
          p_vehicle_id: string
        }
        Returns: {
          carrier_id: string
          created_at: string
          departure_at: string
          destination_commune_id: number
          id: string
          is_active: boolean
          origin_commune_id: number
          price_per_kg_dzd: number
          total_capacity_kg: number
          total_capacity_volume_m3: number | null
          updated_at: string
          vehicle_id: string
        }
        SetofOptions: {
          from: "*"
          to: "oneoff_trips"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      update_route_with_revision: {
        Args: {
          p_default_departure_time: string
          p_destination_commune_id: number
          p_effective_from: string
          p_is_active: boolean
          p_origin_commune_id: number
          p_price_per_kg_dzd: number
          p_recurring_days_of_week: number[]
          p_route_id: string
          p_total_capacity_kg: number
          p_total_capacity_volume_m3: number
          p_vehicle_id: string
        }
        Returns: {
          carrier_id: string
          created_at: string
          default_departure_time: string
          destination_commune_id: number
          effective_from: string
          id: string
          is_active: boolean
          origin_commune_id: number
          price_per_kg_dzd: number
          recurring_days_of_week: number[]
          total_capacity_kg: number
          total_capacity_volume_m3: number | null
          updated_at: string
          vehicle_id: string
        }
        SetofOptions: {
          from: "*"
          to: "routes"
          isOneToOne: true
          isSetofReturn: false
        }
      }
      vehicle_owned_by_current_carrier: {
        Args: { p_vehicle_id: string }
        Returns: boolean
      }
      weekdays_are_valid: { Args: { days: number[] }; Returns: boolean }
      write_admin_audit_log: {
        Args: {
          p_action: string
          p_metadata?: Json
          p_outcome: string
          p_reason?: string
          p_target_id: string
          p_target_type: string
        }
        Returns: {
          action: string
          actor_id: string | null
          actor_role: Database["public"]["Enums"]["app_role"] | null
          correlation_id: string | null
          created_at: string
          id: string
          metadata: Json | null
          outcome: string
          reason: string | null
          target_id: string | null
          target_type: string
        }
        SetofOptions: {
          from: "*"
          to: "admin_audit_logs"
          isOneToOne: true
          isSetofReturn: false
        }
      }
    }
    Enums: {
      admin_invitation_status: "pending" | "accepted" | "expired" | "revoked"
      admin_role: "super_admin" | "ops_admin"
      app_role: "shipper" | "carrier" | "admin"
      booking_status:
        | "pending_payment"
        | "payment_under_review"
        | "confirmed"
        | "picked_up"
        | "in_transit"
        | "delivered_pending_review"
        | "completed"
        | "cancelled"
        | "disputed"
      dispute_status: "open" | "resolved"
      email_delivery_status:
        | "queued"
        | "sending"
        | "sent"
        | "delivered"
        | "opened"
        | "clicked"
        | "render_failed"
        | "soft_failed"
        | "hard_failed"
        | "bounced"
        | "suppressed"
      email_outbox_status:
        | "queued"
        | "processing"
        | "sent_to_provider"
        | "retry_scheduled"
        | "dead_letter"
        | "cancelled"
      ledger_direction: "debit" | "credit"
      payment_rail: "ccp" | "dahabia" | "bank"
      payment_status:
        | "unpaid"
        | "proof_submitted"
        | "under_verification"
        | "secured"
        | "rejected"
        | "refunded"
        | "released_to_carrier"
      payout_request_status: "requested" | "cancelled" | "fulfilled"
      platform_environment: "local" | "production"
      shipment_status: "draft" | "booked" | "cancelled"
      support_message_sender_type: "user" | "admin" | "system"
      support_request_priority: "normal" | "high" | "urgent"
      support_request_status:
        | "open"
        | "in_progress"
        | "waiting_for_user"
        | "resolved"
        | "closed"
      tracking_event_visibility: "internal" | "user_visible"
      transfer_status: "pending" | "sent" | "failed" | "cancelled"
      upload_session_status:
        | "authorized"
        | "finalized"
        | "cancelled"
        | "expired"
      verification_document_entity_type: "profile" | "vehicle"
      verification_status: "pending" | "verified" | "rejected"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  storage: {
    Tables: {
      buckets: {
        Row: {
          allowed_mime_types: string[] | null
          avif_autodetection: boolean | null
          created_at: string | null
          file_size_limit: number | null
          id: string
          name: string
          owner: string | null
          owner_id: string | null
          public: boolean | null
          type: Database["storage"]["Enums"]["buckettype"]
          updated_at: string | null
        }
        Insert: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id: string
          name: string
          owner?: string | null
          owner_id?: string | null
          public?: boolean | null
          type?: Database["storage"]["Enums"]["buckettype"]
          updated_at?: string | null
        }
        Update: {
          allowed_mime_types?: string[] | null
          avif_autodetection?: boolean | null
          created_at?: string | null
          file_size_limit?: number | null
          id?: string
          name?: string
          owner?: string | null
          owner_id?: string | null
          public?: boolean | null
          type?: Database["storage"]["Enums"]["buckettype"]
          updated_at?: string | null
        }
        Relationships: []
      }
      buckets_analytics: {
        Row: {
          created_at: string
          deleted_at: string | null
          format: string
          id: string
          name: string
          type: Database["storage"]["Enums"]["buckettype"]
          updated_at: string
        }
        Insert: {
          created_at?: string
          deleted_at?: string | null
          format?: string
          id?: string
          name: string
          type?: Database["storage"]["Enums"]["buckettype"]
          updated_at?: string
        }
        Update: {
          created_at?: string
          deleted_at?: string | null
          format?: string
          id?: string
          name?: string
          type?: Database["storage"]["Enums"]["buckettype"]
          updated_at?: string
        }
        Relationships: []
      }
      buckets_vectors: {
        Row: {
          created_at: string
          id: string
          type: Database["storage"]["Enums"]["buckettype"]
          updated_at: string
        }
        Insert: {
          created_at?: string
          id: string
          type?: Database["storage"]["Enums"]["buckettype"]
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          type?: Database["storage"]["Enums"]["buckettype"]
          updated_at?: string
        }
        Relationships: []
      }
      iceberg_namespaces: {
        Row: {
          bucket_name: string
          catalog_id: string
          created_at: string
          id: string
          metadata: Json
          name: string
          updated_at: string
        }
        Insert: {
          bucket_name: string
          catalog_id: string
          created_at?: string
          id?: string
          metadata?: Json
          name: string
          updated_at?: string
        }
        Update: {
          bucket_name?: string
          catalog_id?: string
          created_at?: string
          id?: string
          metadata?: Json
          name?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "iceberg_namespaces_catalog_id_fkey"
            columns: ["catalog_id"]
            isOneToOne: false
            referencedRelation: "buckets_analytics"
            referencedColumns: ["id"]
          },
        ]
      }
      iceberg_tables: {
        Row: {
          bucket_name: string
          catalog_id: string
          created_at: string
          id: string
          location: string
          name: string
          namespace_id: string
          remote_table_id: string | null
          shard_id: string | null
          shard_key: string | null
          updated_at: string
        }
        Insert: {
          bucket_name: string
          catalog_id: string
          created_at?: string
          id?: string
          location: string
          name: string
          namespace_id: string
          remote_table_id?: string | null
          shard_id?: string | null
          shard_key?: string | null
          updated_at?: string
        }
        Update: {
          bucket_name?: string
          catalog_id?: string
          created_at?: string
          id?: string
          location?: string
          name?: string
          namespace_id?: string
          remote_table_id?: string | null
          shard_id?: string | null
          shard_key?: string | null
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "iceberg_tables_catalog_id_fkey"
            columns: ["catalog_id"]
            isOneToOne: false
            referencedRelation: "buckets_analytics"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "iceberg_tables_namespace_id_fkey"
            columns: ["namespace_id"]
            isOneToOne: false
            referencedRelation: "iceberg_namespaces"
            referencedColumns: ["id"]
          },
        ]
      }
      migrations: {
        Row: {
          executed_at: string | null
          hash: string
          id: number
          name: string
        }
        Insert: {
          executed_at?: string | null
          hash: string
          id: number
          name: string
        }
        Update: {
          executed_at?: string | null
          hash?: string
          id?: number
          name?: string
        }
        Relationships: []
      }
      objects: {
        Row: {
          bucket_id: string | null
          created_at: string | null
          id: string
          last_accessed_at: string | null
          metadata: Json | null
          name: string | null
          owner: string | null
          owner_id: string | null
          path_tokens: string[] | null
          updated_at: string | null
          user_metadata: Json | null
          version: string | null
        }
        Insert: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          owner_id?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          user_metadata?: Json | null
          version?: string | null
        }
        Update: {
          bucket_id?: string | null
          created_at?: string | null
          id?: string
          last_accessed_at?: string | null
          metadata?: Json | null
          name?: string | null
          owner?: string | null
          owner_id?: string | null
          path_tokens?: string[] | null
          updated_at?: string | null
          user_metadata?: Json | null
          version?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "objects_bucketId_fkey"
            columns: ["bucket_id"]
            isOneToOne: false
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
        ]
      }
      s3_multipart_uploads: {
        Row: {
          bucket_id: string
          created_at: string
          id: string
          in_progress_size: number
          key: string
          owner_id: string | null
          upload_signature: string
          user_metadata: Json | null
          version: string
        }
        Insert: {
          bucket_id: string
          created_at?: string
          id: string
          in_progress_size?: number
          key: string
          owner_id?: string | null
          upload_signature: string
          user_metadata?: Json | null
          version: string
        }
        Update: {
          bucket_id?: string
          created_at?: string
          id?: string
          in_progress_size?: number
          key?: string
          owner_id?: string | null
          upload_signature?: string
          user_metadata?: Json | null
          version?: string
        }
        Relationships: [
          {
            foreignKeyName: "s3_multipart_uploads_bucket_id_fkey"
            columns: ["bucket_id"]
            isOneToOne: false
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
        ]
      }
      s3_multipart_uploads_parts: {
        Row: {
          bucket_id: string
          created_at: string
          etag: string
          id: string
          key: string
          owner_id: string | null
          part_number: number
          size: number
          upload_id: string
          version: string
        }
        Insert: {
          bucket_id: string
          created_at?: string
          etag: string
          id?: string
          key: string
          owner_id?: string | null
          part_number: number
          size?: number
          upload_id: string
          version: string
        }
        Update: {
          bucket_id?: string
          created_at?: string
          etag?: string
          id?: string
          key?: string
          owner_id?: string | null
          part_number?: number
          size?: number
          upload_id?: string
          version?: string
        }
        Relationships: [
          {
            foreignKeyName: "s3_multipart_uploads_parts_bucket_id_fkey"
            columns: ["bucket_id"]
            isOneToOne: false
            referencedRelation: "buckets"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "s3_multipart_uploads_parts_upload_id_fkey"
            columns: ["upload_id"]
            isOneToOne: false
            referencedRelation: "s3_multipart_uploads"
            referencedColumns: ["id"]
          },
        ]
      }
      vector_indexes: {
        Row: {
          bucket_id: string
          created_at: string
          data_type: string
          dimension: number
          distance_metric: string
          id: string
          metadata_configuration: Json | null
          name: string
          updated_at: string
        }
        Insert: {
          bucket_id: string
          created_at?: string
          data_type: string
          dimension: number
          distance_metric: string
          id?: string
          metadata_configuration?: Json | null
          name: string
          updated_at?: string
        }
        Update: {
          bucket_id?: string
          created_at?: string
          data_type?: string
          dimension?: number
          distance_metric?: string
          id?: string
          metadata_configuration?: Json | null
          name?: string
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "vector_indexes_bucket_id_fkey"
            columns: ["bucket_id"]
            isOneToOne: false
            referencedRelation: "buckets_vectors"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      can_insert_object: {
        Args: { bucketid: string; metadata: Json; name: string; owner: string }
        Returns: undefined
      }
      extension: { Args: { name: string }; Returns: string }
      filename: { Args: { name: string }; Returns: string }
      foldername: { Args: { name: string }; Returns: string[] }
      get_common_prefix: {
        Args: { p_delimiter: string; p_key: string; p_prefix: string }
        Returns: string
      }
      get_size_by_bucket: {
        Args: never
        Returns: {
          bucket_id: string
          size: number
        }[]
      }
      list_multipart_uploads_with_delimiter: {
        Args: {
          bucket_id: string
          delimiter_param: string
          max_keys?: number
          next_key_token?: string
          next_upload_token?: string
          prefix_param: string
        }
        Returns: {
          created_at: string
          id: string
          key: string
        }[]
      }
      list_objects_with_delimiter: {
        Args: {
          _bucket_id: string
          delimiter_param: string
          max_keys?: number
          next_token?: string
          prefix_param: string
          sort_order?: string
          start_after?: string
        }
        Returns: {
          created_at: string
          id: string
          last_accessed_at: string
          metadata: Json
          name: string
          updated_at: string
        }[]
      }
      operation: { Args: never; Returns: string }
      search: {
        Args: {
          bucketname: string
          levels?: number
          limits?: number
          offsets?: number
          prefix: string
          search?: string
          sortcolumn?: string
          sortorder?: string
        }
        Returns: {
          created_at: string
          id: string
          last_accessed_at: string
          metadata: Json
          name: string
          updated_at: string
        }[]
      }
      search_by_timestamp: {
        Args: {
          p_bucket_id: string
          p_level: number
          p_limit: number
          p_prefix: string
          p_sort_column: string
          p_sort_column_after: string
          p_sort_order: string
          p_start_after: string
        }
        Returns: {
          created_at: string
          id: string
          key: string
          last_accessed_at: string
          metadata: Json
          name: string
          updated_at: string
        }[]
      }
      search_v2: {
        Args: {
          bucket_name: string
          levels?: number
          limits?: number
          prefix: string
          sort_column?: string
          sort_column_after?: string
          sort_order?: string
          start_after?: string
        }
        Returns: {
          created_at: string
          id: string
          key: string
          last_accessed_at: string
          metadata: Json
          name: string
          updated_at: string
        }[]
      }
    }
    Enums: {
      buckettype: "STANDARD" | "ANALYTICS" | "VECTOR"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  graphql_public: {
    Enums: {},
  },
  public: {
    Enums: {
      admin_invitation_status: ["pending", "accepted", "expired", "revoked"],
      admin_role: ["super_admin", "ops_admin"],
      app_role: ["shipper", "carrier", "admin"],
      booking_status: [
        "pending_payment",
        "payment_under_review",
        "confirmed",
        "picked_up",
        "in_transit",
        "delivered_pending_review",
        "completed",
        "cancelled",
        "disputed",
      ],
      dispute_status: ["open", "resolved"],
      email_delivery_status: [
        "queued",
        "sending",
        "sent",
        "delivered",
        "opened",
        "clicked",
        "render_failed",
        "soft_failed",
        "hard_failed",
        "bounced",
        "suppressed",
      ],
      email_outbox_status: [
        "queued",
        "processing",
        "sent_to_provider",
        "retry_scheduled",
        "dead_letter",
        "cancelled",
      ],
      ledger_direction: ["debit", "credit"],
      payment_rail: ["ccp", "dahabia", "bank"],
      payment_status: [
        "unpaid",
        "proof_submitted",
        "under_verification",
        "secured",
        "rejected",
        "refunded",
        "released_to_carrier",
      ],
      payout_request_status: ["requested", "cancelled", "fulfilled"],
      platform_environment: ["local", "production"],
      shipment_status: ["draft", "booked", "cancelled"],
      support_message_sender_type: ["user", "admin", "system"],
      support_request_priority: ["normal", "high", "urgent"],
      support_request_status: [
        "open",
        "in_progress",
        "waiting_for_user",
        "resolved",
        "closed",
      ],
      tracking_event_visibility: ["internal", "user_visible"],
      transfer_status: ["pending", "sent", "failed", "cancelled"],
      upload_session_status: [
        "authorized",
        "finalized",
        "cancelled",
        "expired",
      ],
      verification_document_entity_type: ["profile", "vehicle"],
      verification_status: ["pending", "verified", "rejected"],
    },
  },
  storage: {
    Enums: {
      buckettype: ["STANDARD", "ANALYTICS", "VECTOR"],
    },
  },
} as const

