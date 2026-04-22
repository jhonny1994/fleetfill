<div dir="rtl">

<p align="center">
  <h1 align="center">FleetFill</h1>
</p>

<p align="center">
  <a href="https://github.com/jhonny1994/fleetfill/releases"><img src="https://img.shields.io/github/v/release/jhonny1994/fleetfill?style=flat-square" alt="GitHub Release"></a>
  <a href="https://github.com/jhonny1994/fleetfill/actions/workflows/ci.yml"><img src="https://img.shields.io/github/actions/workflow/status/jhonny1994/fleetfill/ci.yml?branch=main&style=flat-square&label=CI" alt="CI"></a>
  <img src="https://img.shields.io/badge/لوحة_التحكم-Hosted-brightgreen?style=flat-square" alt="لوحة التحكم">
</p>

<p align="center"><strong>المنصة الذكية لإدارة عمليات الشحن البرّي في الجزائر.</strong></p>

<p align="center">
  يجمع FleetFill الشاحنين والناقلين وفِرق التشغيل داخل منظومة واحدة للحجز، ومراجعة إثبات الدفع، وتتبع الشحنات، والتحقق من الناقلين، وإدارة النزاعات، ومتابعة المستحقات.
</p>

<p align="center">
  <a href="README.en.md">English</a> · <a href="README.fr.md">Français</a>
</p>

## لماذا يهم؟

- مُطابقة دقيقة بين الرحلات والسعات المتاحة
- شفافية كاملة في الأسعار قبل تأكيد الحجز
- مراجعة إثباتات الدفع قبل اعتماد العمليات
- تتبُّع مراحل الشحن وفق محطات تشغيلية فعلية
- إدارة مُهيكلة للنزاعات والمبالغ المستردّة والمستحقات
- واجهة ثلاثية اللغات: العربية والفرنسية والإنجليزية

## الأسطح الحيّة

- إصدارات أندرويد الرسمية: [GitHub Releases](https://github.com/jhonny1994/fleetfill/releases)
- لوحة التشغيل الإدارية: مُهيّأة على مزود الاستضافة الإنتاجي النشط

## ماذا يوجد داخل المستودع؟

يُدار FleetFill بوصفه مستودعًا أحاديًّا عمليًّا بثلاثة أسطح رئيسية:

- `apps/mobile`
  - تطبيق Flutter للشاحنين والناقلين
- `apps/admin-web`
  - لوحة تشغيل داخلية مبنية بـ Next.js
- `backend/supabase`
  - قاعدة البيانات، والسياسات، وواجهات RPC، وEdge Functions

## الجاهزية الإنتاجية

- فرع `main` محمي ويتطلب مراجعة وفحوصات إلزامية
- مسار CI موحَّد لتطبيق الهاتف ولوحة الإدارة والخلفية
- مسارات نشر منفصلة للإدارة، والخلفية، والإصدارات المحمولة
- مسار تنسيق شامل للإطلاق عبر GitHub Actions

ابدأ من هنا إذا كنت تريد الصورة الهندسية بسرعة:

- [فهرس التوثيق](docs/README.md)
- [المعمارية](docs/architecture.md)
- [نموذج التسليم](docs/delivery.md)
- [عمليات الإصدارات](docs/releases.md)

## لمحة بصرية

<div align="center" dir="ltr">

| التطبيق | لوحة الإدارة |
|:-------:|:------------:|
| ![تتبُّع الشحنة](docs/assets/screenshots/mobile/shipper_track.png) | ![مراجعة المدفوعات](docs/assets/screenshots/admin/payments.png) |

</div>

## الوصول وإعادة الاستخدام

هذا المستودع ظاهر للعامة لأغراض التقييم، والمراجعة التقنية، والوصول إلى الإصدارات الرسمية فقط. تبقى الشفرة المصدرية، والوثائق، والمواد المرتبطة ملكية خاصة، ولا يُمنح أي ترخيص لإعادة الاستخدام أو التعديل أو التوزيع أو الاستغلال التجاري.

راجع [PROPRIETARY-NOTICE.md](PROPRIETARY-NOTICE.md) للصياغة الكاملة.

## بُنِي باستخدام

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Supabase-3FCF8E?style=flat-square&logo=supabase&logoColor=white" alt="Supabase">
  <img src="https://img.shields.io/badge/Next.js-000?style=flat-square&logo=next.js&logoColor=white" alt="Next.js">
  <img src="https://img.shields.io/badge/لوحة_إدارية-Hosted-0A7CFF?style=flat-square" alt="لوحة إدارية مستضافة">
</p>

</div>
