module ReceiptsHelper
  def format_amount(amount, currency)
    # TODO: learn how to use number_to_currency

    formats = {
      "usd" => "$%.2f",
      "eur" => "%.2f€"
    }

    formats[currency.downcase] % [ amount.to_f / 100.0 ]
  end
end
