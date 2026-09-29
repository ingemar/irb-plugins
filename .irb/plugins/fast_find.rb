# frozen_string_literal: true

return unless defined?(ApplicationRecord)

# rubocop:disable Naming/BinaryOperatorParameterName

# Usage:
#   > ApplicationRecord.extend(IrbHacks::FastFind)
#   => ApplicationRecord(...)
#   > Home/1
#   => #<Home:0x0000000110ea2598 id: 1, ...>
#
mod = Module.new do
  set_temporary_name "FastFind Plugin"

  def /(id)
    find_by(id:)
  end
end

ApplicationRecord.extend(mod)
# rubocop:enable Naming/BinaryOperatorParameterName
