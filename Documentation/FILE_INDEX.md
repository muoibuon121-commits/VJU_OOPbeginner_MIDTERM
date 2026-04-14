================================================================================
          B2B INVOICE MANAGER macOS - COMPLETE FILE INDEX
================================================================================

Swift source: App, Models, Services, Utilities, Views
Documentation: Documentation/ (README, SETUP_GUIDE, START_HERE, SUMMARY, FILE_INDEX)

================================================================================
DOCUMENTATION (Read These First)
================================================================================

Documentation/START_HERE.md
  → Quick start guide (5 minutes)
  → First file to read
  → Overview & quick setup
  → What's included

Documentation/SETUP_GUIDE.md
  → Detailed installation instructions
  → Step-by-step guide (30 minutes)
  → Core Data setup
  → Troubleshooting

Documentation/README.md
  → Project overview
  → Features list
  → System requirements
  → Usage guide

Documentation/SUMMARY.md
  → Project summary
  → File manifest
  → Statistics
  → Next steps

================================================================================
SWIFT SOURCE CODE
================================================================================

Utilities/Constants.swift (App Configuration)
  → AppConstants struct
  → Window sizes, colors, API settings
  → Finance defaults, sync settings
  → Keyboard shortcuts

App/B2BApp.swift (App Entry Point & Menu)
  → @main app struct
  → AppDelegate class
  → Menu system setup
  → Window management
  → Preferences & About windows

Models/Models.swift (Core Data Entities)
  → Invoice entity with all properties
  → Client entity with all properties
  → Computed properties (remainingAmount, isOverdue, etc.)
  → Display helper methods

Services/CoreDataManager.swift (Data Persistence)
  → Core Data stack setup
  → CRUD operations (create, read, update, delete)
  → Fetch requests
  → Count operations
  → Reset functionality

Services/SyncManager.swift (Data Synchronization)
  → Auto-sync scheduling
  → Manual sync
  → Sync status tracking
  → Last sync date

Utilities/ValidationHelper.swift (Input Validation)
  → Email validation
  → Phone number validation
  → Amount validation
  → Invoice number validation
  → Required field validation
  → VAT/Discount rate validation

Utilities/Extensions.swift (Utility Extensions)
  → Date formatting & calculations
  → Double currency formatting
  → String email/phone validation
  → NSColor convenience init
  → NSNotification extensions

Views/MainWindow.swift
  → NavigationSplitView shell, tab routing, titles

Views/MainSidebar.swift
  → Sidebar list (menu + settings sections)

Views/ListHeaderToolbar.swift
  → List screen header title + primary action button

Views/DashboardView.swift
  → Dashboard statistics layout

Views/StatCard.swift
  → Single statistic card on dashboard

Views/InvoiceListView.swift
  → Composes toolbar + invoice table

Views/InvoiceTableView.swift
  → SwiftUI Table for invoices

Views/ClientsListView.swift
  → Composes toolbar + clients table

Views/ClientsTableView.swift
  → SwiftUI Table for clients

Views/SettingsView.swift
  → Settings screen wrapper + title

Views/SettingsFormView.swift
  → VAT, discount, sync form fields

Views/PreferencesWindow.swift
  → Preferences window (tabbed)

Views/AboutWindow.swift
  → About dialog

================================================================================
QUICK FILE GUIDE
================================================================================

Utilities/Constants.swift
  Use: Change colors, API, currency, etc.
  Edit: AppConstants struct

App/B2BApp.swift
  Use: App entry point, menu setup
  Edit: B2BInvoiceApp, AppDelegate

Models/Models.swift
  Use: Data structure definitions
  Edit: Invoice and Client classes

Services/CoreDataManager.swift
  Use: Data management
  Edit: Save, fetch, delete operations

Views/*.swift
  Use: UI layout and views
  Edit: MainWindow, sidebar, tables, forms

Services/SyncManager.swift
  Use: Background sync
  Edit: Auto-sync logic

Utilities/ValidationHelper.swift
  Use: Input validation
  Edit: Validation functions

Utilities/Extensions.swift
  Use: Helper functions
  Edit: Extension methods

================================================================================
SETUP WORKFLOW
================================================================================

1. READ DOCUMENTATION
   → START_HERE.md (5 min)
   → SETUP_GUIDE.md (reference while setting up)

2. CREATE XCODE PROJECT
   → File → New → Project
   → Select macOS → App
   → Product Name: B2BInvoiceApp
   → Interface: SwiftUI

3. CREATE CORE DATA MODEL
   → File → New → File
   → Data Model
   → Name: B2BInvoice
   → Add 2 entities: Invoice, Client

4. ADD SWIFT FOLDERS
   → Add App, Models, Services, Utilities, Views
   → Ensure target membership for every .swift file

5. BUILD & RUN
   → Product → Build (Cmd+B)
   → Product → Run (Cmd+R)

6. VERIFY
   → App launches
   → Dashboard displays
   → No console errors

================================================================================
FILE LOCATIONS (REPOSITORY LAYOUT)
================================================================================

App/
  └── B2BApp.swift

Models/
  └── Models.swift

Services/
  ├── CoreDataManager.swift
  └── SyncManager.swift

Utilities/
  ├── Constants.swift
  ├── ValidationHelper.swift
  └── Extensions.swift

Views/
  ├── MainWindow.swift
  ├── MainSidebar.swift
  ├── ListHeaderToolbar.swift
  ├── DashboardView.swift
  ├── StatCard.swift
  ├── InvoiceListView.swift
  ├── InvoiceTableView.swift
  ├── ClientsListView.swift
  ├── ClientsTableView.swift
  ├── SettingsView.swift
  ├── SettingsFormView.swift
  ├── PreferencesWindow.swift
  └── AboutWindow.swift

Documentation/
  ├── START_HERE.md
  ├── SETUP_GUIDE.md
  ├── README.md
  ├── SUMMARY.md
  └── FILE_INDEX.md

Core Data (in Xcode project)
  └── B2BInvoice.xcdatamodeld

================================================================================
CUSTOMIZATION POINTS
================================================================================

Easy to Change:
  • Colors → Constants.swift Colors
  • Currency → Constants.swift Finance
  • API endpoint → Constants.swift API
  • App name → Constants.swift appName
  • Menu items → B2BApp.swift
  • UI layout → Views/
  • Validation rules → ValidationHelper.swift

Easy to Extend:
  • Add new models to Core Data
  • Add new views under Views/
  • Add new validation functions
  • Add new menu items
  • Add new keyboard shortcuts
  • Add new sync logic

================================================================================
GETTING HELP
================================================================================

If you need help:

1. Check SETUP_GUIDE.md "Troubleshooting" section
2. Read code comments in .swift files
3. Check Xcode error messages
4. Look at function documentation

Common issues:
  • Can't build → Clean build (Cmd+Shift+K)
  • Core Data crash → Rebuild, check model
  • App won't start → Check AppDelegate
  • Views not showing → Check Views/MainWindow.swift
  • Data not saving → Check CoreDataManager.swift

================================================================================
Version: 1.0.0
Platform: macOS 12.0+
Status: Production Ready
Created: 2024

Start with: Documentation/START_HERE.md
Then follow: Documentation/SETUP_GUIDE.md
Finally: Cmd+R to run!
