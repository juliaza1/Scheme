;; Oppgave 1
;; a - e er vedlagt som *.png
;; f) (car (cdr (cdr '(1 2 3 4)))) eller caddr
;; g) (car (car (cdr '((1 2) (3 4))))) eller caadr
;; h) (car (car (cdr (cdr '((1) (2) (3) (4)))))) eller caaddr
;; i) list: (list (list 1 2) (list 3 4))
;;    cons: (cons (cons 1 (cons 2 '())) (cons (cons 3 (cons 4 '())) '()))

;; Oppgave 2
;; a) 
(define (lengde2 items)
  (let loop ((items items)
             (count 0)) ; loop og teller
    (cond ((null? items) count) ; return count naar listen er tom
          (else (loop (cdr items) (+ count 1)))))) ; loop med neste del av lista og oppdatert teller
  
;; b)
;; jeg kopierte bare eksemplet fra forelesningsfoilene. ;) 
;; copy-list med halerekursjon som gir ut en reversert liste istedenfor en kopi
(define (rev-list items)
  (define (list-iter in out) 
  (if (null? in) 
      out
      (list-iter (cdr in)
                 (cons (car in) out)))) 
  (list-iter items '()))


;; c)
(define (ditch tall items)
  (if (null? items)
      '()
      (if (equal? tall (car items))
          (ditch tall (cdr items))
          (cons (car items) (ditch tall (cdr items))))))

;; Jeg har brukt vanlig rekursjon fordi: funksjonen maa 'huske' verdien fra cons-kallene naar det
;; finner et tall ulik det tallet som skal ditches.
;; Hadde inputen til lista bestaatt av bare det tallet som skal ditches saa hadde det vaert halerekursiv.

;; Hvis lista er n lang så rekurserer den n ganger og lagrer ett tall per rekursjon (hvis det trengs)
;; Forklaring: minnebruk: size of type * storage per call * number of calls
;; hvorav size of type og storaget per call er konstanter. Jeg (som programmerer) har bare innflytelse 
;; paa antall call. (Big-O) O(n)
;; Runtime er proporsjonell med inputens lengde. (Big-O) O(n)
;; Forklaring: tidsbruk: number of instructions per call * number of calls * time per instruction
;; hvorarv time per instruction kan sees paa som en konstant.

;; d)
(define (nth index items)
  (let loop ((items items)
             (count 0)) ; bruker let for aa definere en lokal variabel count og en prosedyre loop
    (cond ((null? items) #f) ; return #f naar lista er tomt
          ((equal? count index) (car items)) ; er count og index like, skal tallet returneres
          (else (loop (cdr items) (+ count 1)))))) ; kall paa loop med oppdaterete parametrene

;; e) 
;; funker nesten som d) bare at 2. cond er annerledes. Er tallet lik det foerste elementet i lista, skrives telleren/indeksen ut
(define (where tall items)
  (let loop ((items items)
             (count 0))
    (cond ((null? items) #f)
          ((equal? tall (car items)) count)
          (else (loop (cdr items) (+ count 1))))))

;; f) 
;; brukte bare map fra forelesningen som mal og addet en liste
(define (map2 proc items1 items2)
  (cond ((or (null? items1) (null? items2)) '())
        (else (cons (proc (car items1) (car items2))
                    (map2 proc (cdr items1) (cdr items2))))))
        
;; g)
(display "2.g):\n")
;; gjennomsnittsberegning ved hjelp av lambda-uttrykk
(map2 (lambda (x y) (/ (+ x y ) 2 )) '(1 2 3 4) '(3 4 5))
;; test to tall om partall, gir ut false hvis minst én av dem er et oddetall
(map2 (lambda (x y) (if (and (even? x) (even? y)) 
                  #t
                  #f)) '(1 2 3) '(3 4 6))

;; h)
(define (both? pred)
  ;; 
  (lambda (a b) (if (and (pred a) (pred b)) 
                    #t
                    #f)))

;; i)
(define (self proc)
  (lambda (a) (proc a a)))








