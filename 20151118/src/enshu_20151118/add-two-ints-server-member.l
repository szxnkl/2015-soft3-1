#!/usr/bin/env roseus
;;;
;;; euslisp version of ros_tutorials/rospy_tutorials/005_add_two_ints
;;;
(ros::load-ros-manifest "roseus")
(ros::roseus "add_two_ints_server")

(defclass advertise-service-class
	:super propertied-object
	:slots ())
(defmethod advertise-service-class 
	(:init () (ros::advertise-service "add_two_ints" roseus::AddTwoInts #'send self :add_two_ints))
	(:add_two_ints (req) (let ((m (send req :response)))
		(format *error-output* "Returning [~d + ~d = ~d]~%"
			(send req :a) (send req :b)
			(+ (send req :a) (send req :b)))
		(send m :sum  (+ (send req :a) (send req :b)))
		m)))
(setq r (instance advertise-service-class :init))
;;;
;(defun add-two-ints (req)
;  (let ((m (send req :response)))
;    (format *error-output* "Returning [~d + ~d = ~d]~%"
;            (send req :a) (send req :b)
;            (+ (send req :a) (send req :b)))
;    (send m :sum  (+ (send req :a) (send req :b)))
;    m))
;;;
;;;
;(ros::roseus "add_two_ints_server")
;(ros::advertise-service "add_two_ints" roseus::AddTwoInts #'add-two-ints)
(do-until-key
	(ros::spin-once))




