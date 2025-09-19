;; health-guardian.clar
;; DevNet Guardian: Secure and Sovereign Health Record Management
;; This contract provides a decentralized, patient-centric system for managing
;; medical records with granular access control and comprehensive audit logging.

;; =============================
;; Constants / Error Codes
;; =============================

;; General errors
(define-constant ERR-UNAUTHORIZED (err u100))
(define-constant ERR-DUPLICATE-REGISTRATION (err u101))
(define-constant ERR-USER-MISSING (err u102))
(define-constant ERR-PROVIDER-UNVERIFIED (err u103))

;; Record errors
(define-constant ERR-RECORD-UNAVAILABLE (err u200))
(define-constant ERR-RECORD-DUPLICATE (err u201))
(define-constant ERR-FORBIDDEN-ACCESS (err u202))

;; Permission errors
(define-constant ERR-PERMISSION-CONFLICT (err u300))
(define-constant ERR-PERMISSION-NONEXISTENT (err u301))
(define-constant ERR-PERMISSION-INVALID (err u302))

;; Role constants
(define-constant ROLE-PATIENT u1)
(define-constant ROLE-PROVIDER u2)
(define-constant ROLE-SYSTEM-ADMIN u3)

;; =============================
;; Data Maps and Variables
;; =============================

;; System administrator tracking
(define-data-var system-administrator principal tx-sender)

;; User registration tracking
(define-map user-registry principal 
  {
    role: uint,              
    active: bool,         
    validated: bool,          
    display-name: (string-utf8 64),  
    registered-at: uint  
  }
)

;; Patient record management
(define-map patient-record-summary principal 
  {
    total-records: uint,          
    last-modified: uint           
  }
)

;; Detailed medical records
(define-map medical-document 
  { patient: principal, document-id: uint } 
  {
    title: (string-utf8 100),            
    category: (string-utf8 50),       
    encrypted-hash: (buff 32),                
    issuing-provider: principal,                 
    created-at: uint,                     
    description: (string-utf8 200)       
  }
)

;; Provider access permissions
(define-map access-control
  { patient: principal, provider: principal }
  {
    granted-at: uint,            
    valid-until: uint,            
    permission-level: uint,          
    record-scope: (list 20 uint)  
  }
)

;; Audit logging mechanism
(define-map access-audit
  uint  
  {
    patient: principal,          
    accessor: principal,         
    action: (string-utf8 20),  
    document-id: uint,             
    timestamp: uint,             
    additional-info: (string-utf8 100)   
  }
)

;; Global sequential counters
(define-data-var audit-sequence uint u0)

;; Private Validation Functions
(define-private (is-patient-profile (user principal))
  (match (map-get? user-registry user)
    user-data (and (is-eq (get role user-data) ROLE-PATIENT) 
                   (get active user-data))
    false
  )
)

(define-private (is-validated-provider (user principal))
  (match (map-get? user-registry user)
    user-data (and (is-eq (get role user-data) ROLE-PROVIDER) 
                   (get active user-data)
                   (get validated user-data))
    false
  )
)

(define-private (is-system-admin (user principal))
  (is-eq user (var-get system-administrator))
)

;; Readonly Utility Functions
(define-read-only (get-user-details (user principal))
  (map-get? user-registry user)
)

(define-read-only (get-patient-summary (patient principal))
  (map-get? patient-record-summary patient)
)

;; Administrative Function
(define-public (update-system-administrator (new-admin principal))
  (begin
    (asserts! (is-system-admin tx-sender) ERR-UNAUTHORIZED)
    (var-set system-administrator new-admin)
    (ok true)
  )
)