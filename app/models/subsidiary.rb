class Subsidiary < ApplicationRecord
  validates :cnpj, presence: true, uniqueness: true, length: {is: 18}
  validate :cnpj_valid

  def cnpj_valid
    if cnpj.present? && !CNPJ.valid?(cnpj)
      errors.add(:cnpj, 'não válido')
    end
  end
end
