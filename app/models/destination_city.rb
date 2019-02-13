class DestinationCity < ApplicationRecord
  default_scope { order(name: :asc) }
end
