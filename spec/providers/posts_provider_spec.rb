require 'rails_helper'

RSpec.describe PostsProvider do
  let!(:post1) { create :post, title: 'Best post of the year' }

  describe '#results' do
    subject { described_class.new(key).results }

    context 'when key is lowercased' do
      let(:key) { 'best' }

      it { is_expected.to include(post1) }
    end

    context 'when key is a prefix' do
      let(:key) { 'Best' }

      it { is_expected.to include(post1) }
    end

    context 'when key is in the middle' do
      let(:key) { 'post' }

      it { is_expected.to include(post1) }
    end

    context 'when key is empty' do
      let(:key) { '' }

      it { is_expected.to be_blank }
    end

    context do
      let(:key) { 'year post' }

      it { is_expected.to include(post1) }
    end

    context do
      let(:key) { 'best posts' }

      it { is_expected.to include(post1) }
    end
  end
end
