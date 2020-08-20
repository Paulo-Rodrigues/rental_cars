class Client < ApplicationRecord
  validates :name, :cpf, :email, presence: true
  validates :cpf, :email, uniqueness: true
  validates :cpf, length: {is: 14}
  validate :cpf_valid

  def cpf_valid
    if cpf.present? && !CPF.valid?(cpf)
      errors.add(:cpf, 'não válido')
    end
  end
end
