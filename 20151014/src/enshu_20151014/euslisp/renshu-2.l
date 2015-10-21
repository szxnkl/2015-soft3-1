#!/usr/bin/env irteusgl

(load "lib/llib/unittest.l")
(init-unit-test)
(send *unit-test* :clear-result)
;; DO NOT EDIT BEFORE THIS LINE


;; 1
(defun dot-1 (n)
  (cond ((= n 0) )
    (t (princ ".")
        (dot-1 (- n 1)))))
(defun dot-2 (n)
  (setq i 0)
  (while (> n i)
    (princ ".")
    (setq i (1+ i)))
  t)
;; 
(assert (dot-1 3) "mondai 1")
(assert (dot-2 3) "mondai 1")

;; 2
(defun hasa-1 (lst)
  (setq ret 0)
  (mapcar #'(lambda (x) (cond ((equal (symbol-name x) "A") (setq ret (1+ ret))))) lst)
    ret)

(defun hasa-2 (lst)
  (cond ((null lst) 0)
    (t
     (setq x (car lst))
     (cond ((equal (symbol-name x) "A") (1+ (hasa-2 (cdr lst))))
           (t (hasa-2 (cdr lst)))))))
;; 
(assert (eq (hasa-1 '(a b c d a)) 2) "mondai 2")
(assert (eq (hasa-2 '(a b c d a)) 2) "mondai 2")

;; DO NOT EDIT AFTER THIS LINE
(send *unit-test* :print-result)
(exit 1)




