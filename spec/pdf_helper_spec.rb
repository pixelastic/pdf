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

  describe 'split' do
    it 'should extract the specified page' do
      # Given
      input = copy(blog)

      # When
      actual = t.split(input: input, range: 3)

      # Then
      expect(File.exist?(actual)).to be true
      expect(t.page_count(actual)).to eq 1
    end
    it 'should extract the specified page with the specified name' do
      # Given
      input = copy(blog)
      output = File.join(File.dirname(input), 'output.pdf')

      # When
      actual = t.split(input: input, output: output, range: 3)

      # Then
      expect(actual).to eq output
      expect(File.exist?(actual)).to be true
      expect(t.page_count(actual)).to eq 1
    end

    it 'should do nothing if the page is out of bounds' do
      # Given
      input = copy(blog)
      output = File.join(File.dirname(input), 'output.pdf')

      # When
      actual = t.split(input: input, output: 'output.pdf', range: 99_999)

      # Then
      expect(actual).to eq nil
      expect(File.exist?(output)).to be false
    end

    it 'should extract a new pdf of the range defined' do
      # Given
      input = copy(blog)

      # When
      actual = t.split(input: input, range: '2-10')

      # Then
      expect(File.exist?(actual)).to be true
      expect(t.page_count(actual)).to eq 9
    end
  end
end
