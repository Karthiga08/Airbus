class OriginCity < ApplicationRecord
  default_scope { order(name: :asc) }
end
