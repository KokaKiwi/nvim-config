(fn if_else [value then else]
  (if value then else))

(fn prefixed [value else]
  (fn [then] (if_else value then else)))

(fn has_package [name]
  (let [[result _] (pcall require name)]
    result))

(set _G.cond {: if_else
              : prefixed
              : has_package})
