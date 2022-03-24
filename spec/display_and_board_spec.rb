require_relative '../lib/display_and_board'

describe DisplayAndBoard do
  describe '#check_if_free' do 
    subject(:display) { described_class.new }
    
    it 'returns true when position is free' do 
      expect(display.check_if_free(0,1)).to eq(true)
    end
    it 'returns true when position is free' do 
      expect(display.check_if_free(1,1)).to eq(true)
    end

    it 'returns false when position is occupied with a symbol' do
      board = [['x',2,'y'],[4,5,6],[7,'x',9]]
      expect(display.check_if_free(0,0,board)).to eq(false)
    end
    it 'returns false when position is occupied with a symbol' do
      board = [['x',2,'y'],[4,5,6],[7,'x',9]]
      expect(display.check_if_free(0,3,board)).to eq(false)
    end
  end 

  describe '#check_win' do
    subject(:win_display) {described_class.new}

    context 'returns true when one player has a win in a' do
      it 'row' do
        board = [['x','x','x'],['y',5,6],['y','x','x']]
        expect(win_display.check_win('x',board)).to eq(true)
      end

      it 'column' do
        board = [['y','x','y'],['x','x',6],['y','x',9]]
        expect(win_display.check_win('x',board)).to eq(true)
      end

      it 'diagonal' do
        board = [['y','x','y'],['x','y',6],['y','x',9]]
        expect(win_display.check_win('y',board)).to eq(true)
      end 
    end
  end

end