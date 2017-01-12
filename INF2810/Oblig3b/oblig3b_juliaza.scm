;; TODO
;; 3e

(load "evaluator.scm")

(set! the-global-environment (setup-environment))
(read-eval-print-loop)

;; ---------------------------------------- 1a --------------------------------------------------------------------- 
;; (define (foo cond else)
;;    (cond ((= cond 2) 0)
;;          (else (else cond))))
;; (define cond 3)
;; (define (else x) (/ x 2))
;; (define (square x) (* x x))

;; (foo 2 square) -----> 0
;; cond-uttrykket på linje 2 "(cond ..." er et faktisk cond-uttrykk og ikke 
;; variablen "cond", som er bundet til 2.
;; Det betyr at cond evaluerer (= cond 2), som er true og returnerer 0.

;; (foo 4 square) -----> 16
;; Det første cond-uttrykket (= cond 2) er false (var. cond er bundet til 4), altså
;; hopper den til else-delen av cond-uttrykket: (else (else cond))
;; else-n i (else cond) er bundet til prosedyren square som tar ett argument.
;; (else cond) --> (square cond) --> (square 4) --> 16.

;; (cond ((= cond 2) 0)
;;       (else (else 4))) -----> 2
;; Variablen cond er nå bundet til 3. 3 er ikke 2 altså er første delen false.
;; Hopper til else-delen, der else er bundet til procedyren: (else x) (/ x 2)
;; 4 delt med 2 er 2.
         
;; ---------------------------------------- 2a --------------------------------------------------------------------- 
;; la til følgende i evaluator.scm i (define primitiv-procedure ...)
;; (list '1+ 
;;     (lambda (x) (+ x 1)))
;; (list '1-
;;     (lambda (x) (- x 1)))

;; ---------------------------------------- 2b --------------------------------------------------------------------- 
;; la til følgende i evaluator.scm
;; (define (install-primitive! proc-name proc)
;;   (begin (set! primitive-procedures       
;;               (cons (list proc-name proc) primitive-procedures))
;;         (set! the-global-environment      
;;               (extend-environment (primitive-procedure-names)
;;                                   (primitive-procedure-objects)
;;                                   the-global-environment))))

;; ---------------------------------------- 3a --------------------------------------------------------------------- 
;; endringer i (define (eval-special-form exp env)...
;; tilføyde: 
;; ((and? exp) (eval-and exp env)) og ((or? exp) (eval-or exp env))
;; endringer i (define (special-form? exp)..
;; tilføyde:
;; ((and? exp) #t) og ((or? exp) #t)

;; ---------------------------------------- 3b --------------------------------------------------------------------- 
;; kaller funksjonen for new_if for å unngå mix-up med if som finnes fra før.
;; endringer i (define (eval-special-form exp env)...
;; tilføyde:
;; ((new_if? exp) (eval-new_if exp env))
;; endringer i (define (special-form? exp)..
;; ((new_if? exp) #t)
;; og:
;; (define (new_if? exp) (tagged-list? exp 'new_if))
;; (define (eval-new_if exp env)
  ;; (if (tagged-list? (cddr exp) 'then)
      ;; (eval-new_if-then exp env)   
      ;; (eval-new_if exp env))) 
;; (define (eval-new_if-then exp env)
  ;; (cond ((tagged-list? exp 'else)
         ;; (mc-eval (cadr exp) env))
        ;; ((and (or (tagged-list? exp 'new_if)
                  ;; (tagged-list? exp 'elsif))
                  ;; (mc-eval (cadr exp) env)) 
         ;; (mc-eval (cadddr exp) env))
        ;; (else (eval-new_if-then (cddddr exp) env))))

;; ---------------------------------------- 3c --------------------------------------------------------------------- 
;; endringer i (define (eval-special-form exp env)...
;; tilføyde:
;; ((let? exp) (let->lambda exp env))
;; endringer i (define (special-form? exp)..
;; ((let? exp) #t) 
;; og:
;; (define (let? exp) (tagged-list? exp 'let))
;; (define (let-args exp) (cadr exp)) ;; <var1> <exp1> <var2> <exp2>..
;; (define (let-var exp) (map car (let-args exp))) ;; <var1> <var2> ..
;; (define (let-exps exp) (map cadr (let-args exp))) ;; <exp1> <exp2> ..
;; (define (let-body exp) (caddr exp)) ;;<body>
;; (define (let->lambda exp env) ;; delene settes sammen i riktig lambda-rekkefølge
  ;; (mc-eval (cons (make-lambda (let-var exp) (list (let-body exp))) (let-exps exp)) env))

;; ---------------------------------------- 3d --------------------------------------------------------------------- 
;; endringer i (define (eval-special-form exp env)...
;; tilføyde:
;; ((new_let? exp) (new_let->lambda exp env))
;; endringer i (define (special-form? exp)..
;; ((new_let? exp) #t)
;; og:
;; (define (new_let? exp) (tagged-list? exp 'new_let))
;; (define (new_let-args exp) (cdr exp)) ;;<var1> = <exp1> and <var2> = exp2>.. in <body>
  
;; ;; plukker ut <var1> <var2> .. exp
;; (define (new_let-var exp)
  ;; (define (get-var var exp)
    ;; (let ((var (cons (car exp) var))) ;; omvendt rekkefølge
     ;; (if (equal? (cadddr exp) 'and)
          ;; (get-var var (cddddr exp))
          ;; (reverse var))))
  ;; (get-var '() (new_let-args exp)))
  
;; ;; plukker ut <exp1> <exp2> .. fra exp  
;; (define (new_let-exps exp)
  ;; (define (get-exp exps exp)
    ;; (let ((exps (cons (caddr exp) exps))) ;; omvendt rekkefølge
      ;; (if (equal? (cadddr exp) 'and)
        ;; (get-exp exps (cddddr exp))
        ;; (reverse exps))))
  ;; (get-exp '() (new_let-args exp)))

;; ;; plukker ut <body> fra exp
;; (define (new_let-body exp) 
  ;; (if (null? (cdr exp))
    ;; (car exp)
    ;; (new_let-body (cdr exp))))

;; (define (new_let->lambda exp env)
  ;; (mc-eval (cons (make-lambda (new_let-var exp) (list (new_let-body exp))) (new_let-exps exp)) env))

;; ---------------------------------------- 3e --------------------------------------------------------------------- 
;; endringer i (define (eval-special-form exp env)...
;; tilføyde:
;; ((while? exp) (eval-while exp env))
;; endringer i (define (special-form? exp)..
;; ((while? exp) #t) 
;; og:
;; (define (while? exp) (tagged-list? exp 'while))  
;; (define (while-condition exp) (cadr exp))        
;; (define (while-body exp) (caddr exp))  
    
;; (define (eval-while exp env) 
;;   (let ((predicate (while-condition exp))
;;         (body (while-body exp)))
;;       (list 'let 'while-loop '()
;;              (make-if predicate
;;                       (append (cons 'begin body)
;;                               (list (cons 'while-loop '())))
;;                       'true))))