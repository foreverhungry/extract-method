class ReceiptPrinter
  COST = {
    'meat' => 5,
    'milk' => 3,
    'candy' => 1,
  }

  TAX = 0.05

  def initialize(output: $stdout, items:)
    @output = output
    @items = items
  end

  def print
    output_items
    output_divider
    output_subtotal
    output_tax
    output_divider
    output_total
  end

  private

  attr_reader :output, :items

  def divider
    '-' * 13
  end

  def item_cost(item)
    COST[item]
  end

  def subtotal
    @subtotal ||= items.reduce(0) { |sum, item| sum + item_cost(item).to_i }
  end

  def tax_amount
    subtotal * TAX
  end

  def total_amount
    subtotal + (subtotal * TAX)
  end

  def output_with(label:, value:)
    output.puts "#{label}: #{sprintf('$%.2f', value)}"
  end

  def output_items
    items.each { |item| output_with(label: item, value: item_cost(item)) }
  end

  def output_subtotal
    output_with(label: "subtotal", value: subtotal)
  end

  def output_tax
    output_with(label: "tax", value: tax_amount)
  end

  def output_total
    output_with(label: "total", value: total_amount)
  end

  def output_divider
    output.puts divider
  end
end
