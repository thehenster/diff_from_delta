require File.join(File.dirname(__FILE__), "../lib/diff_from_delta")

describe "#diff_from_delta" do
  
  initial_text = "The quick\nbrown fox\njumped over\nthe lazy dog"
  
  examples = [
    {:delta => "=4\t-5\t+slow\t=35", :result => "The slow\nbrown fox\njumped over\nthe lazy dog"},
    {:delta => "=35\t-5\t=4", :result => "The quick\nbrown fox\njumped over\nthe dog"},
    {:delta => "=4\t-5\t+daft\t=35\t+%20twice", :result => "The daft\nbrown fox\njumped over\nthe lazy dog twice"},
    {:delta => "-44\t+Barnacles", :result => "Barnacles"},
    ]
  
  examples.each do |example|
    it "should process the delta #{example[:delta]} correctly" do
      DiffFromDelta::compile_diff_from_delta(initial_text, example[:delta]).should == example[:result]
    end
  end
  
end