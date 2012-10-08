{-# LANGUAGE GADTs, TypeFamilies, TemplateHaskell, QuasiQuotes, FlexibleInstances #-}
module Migration.New where
import Database.Groundhog
import Database.Groundhog.TH

data AddColumn = AddColumn {addColumnNew :: Maybe String, addColumnOld :: Int} deriving (Eq, Show)
data AddUniqueConstraint = AddUniqueConstraint {addUniqueConstraint1 :: Int, addUniqueConstraint2 :: String} deriving (Eq, Show)
data AddUniqueIndex = AddUniqueIndex {addUniqueIndex1 :: Int, addUniqueIndex2 :: String} deriving (Eq, Show)
data AddConstructorToMany = AddConstructorToMany0 {addConstructorToMany0 :: Int}
                          | AddConstructorToMany1 {addConstructorToMany1 :: Int}
                          | AddConstructorToMany2 {addConstructorToMany2 :: String} deriving (Eq, Show)
data AddNotNull = AddNotNull {addNotNull :: String} deriving (Eq, Show)

mkPersist defaultCodegenConfig [groundhog|
- entity: AddColumn
- entity: AddUniqueConstraint
  constructors:
    - name: AddUniqueConstraint
      uniques:
        - name: unique_key
          fields: [addUniqueConstraint1, addUniqueConstraint2]
- entity: AddUniqueIndex
  constructors:
    - name: AddUniqueIndex
      uniques:
        - name: unique_key
          type: index
          fields: [addUniqueIndex1, addUniqueIndex2]
- entity: AddConstructorToMany
- entity: AddNotNull
|]