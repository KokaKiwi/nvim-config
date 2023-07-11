(fn table.map [t f ?to_map]
  (let [result []]
    (each [_ item (ipairs t)]
      (if ?to_map
        (let [[left right] (f item)]
          (when (~= left nil)
            (tset result left right)))
        (let [res (f item)]
          (table.insert result res))))
    result))

(fn table.dmap [t f ?to_list]
  (let [result {}]
    (each [key value (pairs t)]
      (let [[a b] (f key value)]
        (if (~= b nil)
          (tset result a b)
          (if ?to_list
            (table.insert result a)
            (tset result key a)))))
    result))

(fn table.any [t f]
  (var result false)
  (each [_ item (ipairs t) &until result]
    (when (f item) (set result true)))
  result)

(fn table.contains [t value]
  (table.any t (fn [item] (= item value))))

(fn table.filter [t f]
  (let [result []]
    (each [_ item (ipairs t)]
      (when (f item)
        (table.insert result item)))
    result))

(fn table.dfilter [t f]
  (local result {})
  (each [key value (pairs t)]
    (when (f key value)
      (tset result key value)))
  result)

(fn table.filterkeys [t keys]
  (table.dfilter t (fn [key _]
               (table.contains keys key))))

(fn table.filtermap [t f]
  (local result [])
  (each [_ item (ipairs t)]
    (let [[res value] (f item)]
      (when res
        (table.insert result value))))
  result)

(fn table.fjoin [tables]
  (local result [])
  (each [_ t (ipairs tables)]
    (each [_ item (ipairs t)]
      (table.insert result item)))
  result)

(fn table.fdjoin [tables]
  (local result {})
  (each [_ t (ipairs tables)]
    (each [key value (pairs t)]
      (tset result key value)))
  result)

(fn table.djoin [...]
  (table.fdjoin [...]))

(fn table.join [...]
  (table.fjoin [...]))

(fn table.extends [t items]
  (if (= items nil)
    (partial table.extends t)
    (do
      (each [_ item (ipairs items)]
        (table.insert t item))
      t)))

(fn table.dextends [t items]
  (if (= items nil)
    (partial table.dextends t)
    (do
      (each [_ item (pairs items)]
        (table.insert t item))
      t)))

(fn table.append [t ...]
  (table.extends t [...]))

(fn table.keys [t]
  (local keys [])
  (each [key _ (pairs t)]
    (table.insert keys key))
  keys)

(fn table.resolve [t path]
  (accumulate [cur t _ key (ipairs path)]
              (. cur key)))

(fn table.copy [t deep?]
  (local deep? (if (~= deep? nil) deep? true))
  (local seen {})
  (fn do_copy [t]
    (if (~= (. seen t) nil)
      (. seen t)
      (let [copy {}]
        (tset seen t copy)
        (each [k v (pairs t)]
          (tset copy k
                (if (and deep? (= (type v) "table")) (do_copy v) v)))
        (setmetatable copy (getmetatable t)))))
  (do_copy t))
