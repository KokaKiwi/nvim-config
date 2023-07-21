(import-macros {: ??} :macros)

(local Lazy
  (let
    [init (fn [self initializer cached]
            (set self.__initializer initializer)
            (set self.__initialized false)
            (set self.__cached (?? cached true)))
     base {:__getvalue (fn [self]
                         (if
                           (not self.__cached)
                           (self.__initializer)
                           (not self.__initialized)
                           (let [value (self.__initializer)]
                             (set self.__initializer nil)
                             (set self.__initialized true)
                             (set self.__value value)
                             value)
                           self.__value))}
     metatable {:__index (fn [self key]
                           (let [value (self:__getvalue)]
                             (. value key)))
                :__call (fn [self ...]
                          (let [value (self:__getvalue)]
                            (value ...)))}]
    (_G.class.new init base metatable)))

(set _G.lazy {: Lazy})
_G.lazy
