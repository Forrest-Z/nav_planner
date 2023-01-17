;; Auto-generated. Do not edit!


(when (boundp 'sineva_nav::SaveMapping)
  (if (not (find-package "SINEVA_NAV"))
    (make-package "SINEVA_NAV"))
  (shadow 'SaveMapping (find-package "SINEVA_NAV")))
(unless (find-package "SINEVA_NAV::SAVEMAPPING")
  (make-package "SINEVA_NAV::SAVEMAPPING"))
(unless (find-package "SINEVA_NAV::SAVEMAPPINGREQUEST")
  (make-package "SINEVA_NAV::SAVEMAPPINGREQUEST"))
(unless (find-package "SINEVA_NAV::SAVEMAPPINGRESPONSE")
  (make-package "SINEVA_NAV::SAVEMAPPINGRESPONSE"))

(in-package "ROS")





(defclass sineva_nav::SaveMappingRequest
  :super ros::object
  :slots (_save_signal _save_path ))

(defmethod sineva_nav::SaveMappingRequest
  (:init
   (&key
    ((:save_signal __save_signal) "")
    ((:save_path __save_path) "")
    )
   (send-super :init)
   (setq _save_signal (string __save_signal))
   (setq _save_path (string __save_path))
   self)
  (:save_signal
   (&optional __save_signal)
   (if __save_signal (setq _save_signal __save_signal)) _save_signal)
  (:save_path
   (&optional __save_path)
   (if __save_path (setq _save_path __save_path)) _save_path)
  (:serialization-length
   ()
   (+
    ;; string _save_signal
    4 (length _save_signal)
    ;; string _save_path
    4 (length _save_path)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _save_signal
       (write-long (length _save_signal) s) (princ _save_signal s)
     ;; string _save_path
       (write-long (length _save_path) s) (princ _save_path s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _save_signal
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _save_signal (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _save_path
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _save_path (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass sineva_nav::SaveMappingResponse
  :super ros::object
  :slots (_success_flag ))

(defmethod sineva_nav::SaveMappingResponse
  (:init
   (&key
    ((:success_flag __success_flag) 0)
    )
   (send-super :init)
   (setq _success_flag (round __success_flag))
   self)
  (:success_flag
   (&optional __success_flag)
   (if __success_flag (setq _success_flag __success_flag)) _success_flag)
  (:serialization-length
   ()
   (+
    ;; int64 _success_flag
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _success_flag
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _success_flag (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _success_flag) (= (length (_success_flag . bv)) 2)) ;; bignum
              (write-long (ash (elt (_success_flag . bv) 0) 0) s)
              (write-long (ash (elt (_success_flag . bv) 1) -1) s))
             ((and (class _success_flag) (= (length (_success_flag . bv)) 1)) ;; big1
              (write-long (elt (_success_flag . bv) 0) s)
              (write-long (if (>= _success_flag 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _success_flag s)(write-long (if (>= _success_flag 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _success_flag
#+(or :alpha :irix6 :x86_64)
      (setf _success_flag (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _success_flag (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass sineva_nav::SaveMapping
  :super ros::object
  :slots ())

(setf (get sineva_nav::SaveMapping :md5sum-) "5fe2de99ca88e365b15343be61af7c60")
(setf (get sineva_nav::SaveMapping :datatype-) "sineva_nav/SaveMapping")
(setf (get sineva_nav::SaveMapping :request) sineva_nav::SaveMappingRequest)
(setf (get sineva_nav::SaveMapping :response) sineva_nav::SaveMappingResponse)

(defmethod sineva_nav::SaveMappingRequest
  (:response () (instance sineva_nav::SaveMappingResponse :init)))

(setf (get sineva_nav::SaveMappingRequest :md5sum-) "5fe2de99ca88e365b15343be61af7c60")
(setf (get sineva_nav::SaveMappingRequest :datatype-) "sineva_nav/SaveMappingRequest")
(setf (get sineva_nav::SaveMappingRequest :definition-)
      "string save_signal
string save_path
---
int64 success_flag
")

(setf (get sineva_nav::SaveMappingResponse :md5sum-) "5fe2de99ca88e365b15343be61af7c60")
(setf (get sineva_nav::SaveMappingResponse :datatype-) "sineva_nav/SaveMappingResponse")
(setf (get sineva_nav::SaveMappingResponse :definition-)
      "string save_signal
string save_path
---
int64 success_flag
")



(provide :sineva_nav/SaveMapping "5fe2de99ca88e365b15343be61af7c60")


