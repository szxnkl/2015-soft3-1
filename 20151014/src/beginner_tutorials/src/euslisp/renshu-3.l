#!/usr/bin/env irteusgl

(load "lib/llib/unittest.l")
(init-unit-test)
(send *unit-test* :clear-result)
;; DO NOT EDIT BEFORE THIS LINE

(defun unittest-error (code msg1 form &optional (msg2))
  (format *error-output* "~C[1;3~Cm~A unittest-error: ~A"
	  #x1b (+ 1 48)   *program-name* msg1)
  (if msg2 (format *error-output* " ~A" msg2))
  (if form (format *error-output* " in ~s" form))
  (format *error-output* ", exitting...~C[0m~%"  #x1b)
  (when code
    (format *error-output* "~C[3~Cm[ERROR] test ~A failed" #x1b 49 form)
    (format *error-output* " ... (~A ~A)" msg1 code)
    (format *error-output* ".~C[0m~%" #x1b))
  (exit 1))

(lisp::install-error-handler 'unittest-error)

;; 
(defun summit (lst)
  (setq lst_new (remove nil lst))
  (apply #'+ lst_new))

;;removeは除いたものを返すだけで引数そのものを破壊的に変更しない
(assert (equal (summit '(1 2 nil 3 4 nil)) 10) "mondai 1")

(defun summit (lst)
 (cond ((null lst) 0)
   (t
    (setq x (car lst))
    (cond ((null x)
           (summit (cdr lst)))
           (t (+ x (summit (cdr lst))))))))
;;終了条件が無いので無限に再帰が呼ばれてしまう
(assert (equal (summit '(1 2 nil 3 4 nil)) 10) "mondai 1")

;;
;; DO NOT EDIT AFTER THIS LINE
(send *unit-test* :print-result)
(exit 1)






