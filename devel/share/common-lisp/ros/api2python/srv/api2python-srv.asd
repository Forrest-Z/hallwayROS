
(cl:in-package :asdf)

(defsystem "api2python-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :nav_msgs-msg
)
  :components ((:file "_package")
    (:file "api_info" :depends-on ("_package_api_info"))
    (:file "_package_api_info" :depends-on ("_package"))
  ))