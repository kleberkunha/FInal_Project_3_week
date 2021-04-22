require_relative '../lib/getting_emails_and_names'

describe 'getting_all_emails' do
  it 'check if works' do
    expect(getting_all_emails == true)
  end
end
