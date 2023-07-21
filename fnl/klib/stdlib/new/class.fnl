(require "klib.stdlib.table")

(fn new [init base mt]
  (let [base (if (~= base nil) base {})]
    (fn [...]
      (let [base (table.copy base false)]
        (let [obj (setmetatable base mt)]
          (init obj ...)
          obj)))))

(set _G.class {: new})
