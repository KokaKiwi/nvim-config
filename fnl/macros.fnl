;; [nfnl-macro]

(fn ?? [value default]
  `(if (~= ,value nil) ,value ,default))

{: ??}
