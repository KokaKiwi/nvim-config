(fn lua_partial [f ...]
  (let [pargs [...]]
    (fn [...]
      (let [args [...]]
        (f (unpack (table.join pargs args)))))))

(set _G.func {:partial lua_partial})
