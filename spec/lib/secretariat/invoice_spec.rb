require "spec_helper"

RSpec.describe Secretariat::Invoice do
  let(:seller) {
    Secretariat::TradeParty.new(
      name: "Depfu inc",
      street1: "Quickbornstr. 46",
      city: "Hamburg",
      postal_code: "20253",
      country_id: "DE",
      vat_id: "DE304755032"
    )
  }

  let(:buyer) {
    Secretariat::TradeParty.new(
      name: "Depfu inc",
      street1: "Quickbornstr. 46",
      city: "Hamburg",
      postal_code: "20253",
      country_id: "SE",
      vat_id: "SE304755032"
    )
  }

  let(:line_item) {
    Secretariat::LineItem.new(
      name: "Depfu Starter Plan",
      quantity: 1,
      gross_amount: "29",
      net_amount: "29",
      unit: :PIECE,
      charge_amount: "29",
      tax_category: :REVERSECHARGE,
      tax_percent: 0,
      tax_amount: "0",
      origin_country_code: "DE",
      currency_code: "EUR"
    )
  }

  subject {
    described_class.new(
      id: "12345",
      issue_date: Date.today,
      seller: seller,
      buyer: buyer,
      line_items: [line_item],
      currency_code: "USD",
      payment_type: :CREDITCARD,
      payment_text: "Kreditkarte",
      tax_category: :REVERSECHARGE,
      tax_percent: 0,
      tax_amount: "0",
      basis_amount: "29",
      grand_total_amount: 29,
      due_amount: 0,
      paid_amount: 29,
      buyer_reference: "REF-112233"
    )
  }

  describe "valid xml schema version 2" do
    let(:xml) { subject.to_xml(version: 2)}

    let(:validator) { Secretariat::Validator.new(xml, version: 2) }

    it {
      expect(validator.validate_against_schema).to be_empty
    }
  end

  describe "valid xml schema version 1" do
    let(:xml) { subject.to_xml(version: 1)}

    let(:validator) { Secretariat::Validator.new(xml, version: 1) }

    it {
      expect(validator.validate_against_schema).to be_empty
    }
  end

  describe "valid xml schematron version 2" do
    let(:xml) { subject.to_xml(version: 2)}

    let(:validator) { Secretariat::Validator.new(xml, version: 2) }

    it {
      expect(validator.validate_against_schematron).to be_empty
    }
  end

  describe "valid xml schematron version 1" do
    let(:xml) { subject.to_xml(version: 1)}

    let(:validator) { Secretariat::Validator.new(xml, version: 1) }

    it {
      pending
      expect(validator.validate_against_schematron).to be_empty
    }
  end
end
