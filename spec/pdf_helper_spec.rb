require 'spec_helper'

describe(PdfHelper) do
  let(:t) { Class.new { include PdfHelper }.new }
  let(:blog) { fixture('blog.pdf') }
  let(:jpg) { fixture('image.jpg') }

  describe 'info' do
    it 'should return a hash of data' do
      # Given
      input = blog

      # When
      actual = t.info(input)

      # Then
      expect(actual).to be_a(Hash)
    end

    it 'should return null if input not a pdf' do
      # Given
      input = jpg

      # When
      actual = t.info(input)

      # Then
      expect(actual).to eq nil
    end
  end

  describe 'pdf?' do
    it 'should return true if file is a pdf' do
      # Given
      input = blog

      # When
      actual = t.pdf?(input)

      # Then
      expect(actual).to eq true
    end

    it 'should return false if file is not a pdf' do
      # Given
      input = jpg

      # When
      actual = t.pdf?(input)

      # Then
      expect(actual).to eq false
    end
  end

  describe 'page_count' do
    it 'should return the number of pages' do
      # Given
      input = blog

      # When
      actual = t.page_count(input)

      # Then
      expect(actual).to eq 19
    end

    it 'should return nil if not a pdf' do
      # Given
      input = jpg

      # When
      actual = t.page_count(input)

      # Then
      expect(actual).to eq nil
    end
  end

end
