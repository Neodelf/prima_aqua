class Price < ActiveRecord::Base
  belongs_to :aqua
  belongs_to :volume

  default_scope -> { order(:start_count) }
end
