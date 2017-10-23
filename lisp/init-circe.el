(setq circe-network-options
      '(("Freenode"
         :tls t
         :nick "optonox"
         :sasl-username "optonox"
         :sasl-password (lambda (x) (read-passwd "SASL password: "))
         )))

(provide 'init-circe)
