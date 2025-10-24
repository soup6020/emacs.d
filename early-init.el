;;; Gotta go fast!
;;; Unset by a hook in init.el after elpaca is loaded
(setq gc-cons-threshold most-positive-fixnum)
;;; Disable package.el in favour of elpaca
(setq package-enable-at-startup nil)
