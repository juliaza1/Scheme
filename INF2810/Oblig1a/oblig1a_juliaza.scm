;; Oppgave 1 
;; a) 
;; Svar: 20. 
;; -> Først 2+2 = 4 , så ganget med 5 = 20

;; b) 
;; Svar: "application: not a procedure; expected a procedure that can be applied to arguments given: 5 arguments...: [none]"
;; -> For mange parenteser. Forventer en prosedyre (5) som ikke er der

;; c)
;; Svar: "application: not a procedure; expected a procedure that can be applied to arguments given: 2 arguments.:"
;; -> Feil måte å skrive 2+2 på. Må være (+ 2 2)

;; d)
;; Svar: bar = 2
;; -> definerer bar med verdien som er resultatet av regneoperasjonen 4/2

;; e)
;; Svar 1 (gitt d): 0
;; -> simpel regneoperasjon. verdien i bar er 2 og 2-2 er 0
;; Svar 2 (ikke gitt d): "bar: undefined; cannot reference undefined identifier"
;; -> ukjent variabel "bar"

;; f)
;; Svar 1 (gitt d): 12
;; -> bar er fremdeles 2. 2*3*4*1 = 24. Delt på bar [altså 2] = 12.
;; Svar 2 (ikke gitt d): se svaralternativ 2 i e)


;; Oppgave 2
;; a)
;; (i)
;; Evaluerer til "piff". 
;; expressions are evaluated from left to right, and the value of the first expression that evaluates to a true value is returned. 
;; Any remaining expressions are not evaluated. If all expressions evaluate to false values, the value of the last expression is returned. 
;; If there are no expressions then #f is returned. 

;; (ii)
;; Evaluerer til #f
;; se forklaring på (i)

;; Syntaksfeil: (and [E1]...[En]) eller (or[E1]...[En])
;; både (i) og (ii) mangler et annet uttrykk

;; (iii)
;; Evaluerer til "poff"
;; Hvis tallet 42 er et positivt tall så utføres "poff". Den udefinerte prosedyren "i-am-not-defined" blir ignorert.
;; Hadde det stått (positive? -42) hadde ikke "poff" blitt utført men "i-am-undefined". Og siden den ikke er definert, 
;; hadde Scheme klaget med en feilmelding.

;; s.19 i SICP: "Notice that 'and' and 'or' are special forms, not procedures, because the subexpressions are not 
;; necessarily all evaluated."

;; b)
;; (if)
(define (sign_if x)
  ;; if x > 0: return 1, else if x = 0: return 0, else if x < 0: return -1
  (if (> x 0) 1 
      (if (= x 0) 0 
          (if (< x 0) -1))))
 
;; (cond)
(define (sign_cond x)
  ;; if x > 0: return 1; x < 0: return -1; else: return 0
  (cond ((> x 0) 1)
        ((< x 0) -1)
        (else 0)))

;; c)
(define (sign_uten x)
  ;; satt en øvre og nedre grense på verdier.
  (or (and (or (> x 0) (= x 0))
           (or (< x 0) (= x 0)) ;; x = 0: set 0
           (display "0\n"))
     (and (> x 0) (< x 999999999999) 
          (display "1\n")) ;; 0 < x < 999999999999: set 1 
     (and (< x 0) (> x -999999999999) 
          (display "-1\n"))) ;; -999999999999 > x > 0: set -1
  (display "X er ikke innenfor rammen [-999999999999 < x < 999999999999]"))

  

;; Oppgave 3
;; a)
(define (add1 i) 
  (+ i 1))
(define (sub1 j)
  (- j 1))
     
;; b)
(define (plus x y)
  ;; kjører så lenge til enten x eller y er 0.
  (cond ((zero? x) y)         ;; hvis x = 0: set y
        ((zero? y) x)         ;; hvis y = 0: set x
        ((< x 0) (plus (add1 x) (sub1 y))) ;; hvis x < 0: rekursiv kall på plus med oppdaterte argumenter (x + 1 og y - 1)
        ((or (< y 0) (> x 0) (> y 0)) (plus (sub1 x) (add1 y))))) ;; hvis y < 0 eller x > 0 eller y > 0: rekursiv kall på plus 
                                                                  ;; med oppdaterte argumenter(x - 1  og y + 1)
 
;; c)
;; Min prosess i (b) er iterativ fordi verdiene til x og y oppdateres med hver 'iterasjon' til en av dem (eller begge) er 0.
;; Saa blir den motsatte verdien returnert.
;; Eksempel paa kjoering
;; (plus 2 3) 
;; (plus 1 4)
;; (plus 0 5) 
;; 5 (x = 0, iterasjonen avsluttes)

;; rekursiv
(define (pluss a b)
  (if (= a 0)
      b
      (if (> a 0)
          (add1 (pluss (sub1 a) b))
          (if (and (< a 0) (> b 0))
              (add1 (pluss (add1 a) b))
              (sub1 (pluss (add1 a) b))))))
;; Eksempel paa kjoering
;; (pluss 3 4)
;; (add1 (pluss 2 4))
;; (add1 (add1 (pluss 1 4)))
;; (add1 (add1 (add1 (pluss 0 4))))
;; (add1 (add1 (add1 4)
;; (add1 (add1 5))
;; (add1 6)
;; 7

  
;; d)
(define (power-close-to b n)
  (define (power-iter e)
    (if (> (expt b e) n)
        e
        (power-iter (+ 1 e))))
  (power-iter 1))


   
    










