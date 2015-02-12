module ExercisesHelper
  def generate_tests(exid,language,base_class,test_method)
    tests=''
    exercise = Exercise.find(exid)
    exercise.coding_question.test_cases.each_with_index do |test_case,i|
      i+=1
      if language=='Ruby'
      tests=tests+"\tdef test#{base_class}#{i}"+"\n"
      tests=tests+"\t\tif #{test_method}(#{test_case.input})==#{test_case.expected_output}"+"\n"
      tests=tests+"\t\t\t@@f.write(\"1,,#{i}\\n\") "+"\n"+"\t\telse\n"
      tests=tests+"\t\t\t@@f.write(\"0,#{test_case.negative_feedback},#{i}\\n\")"+"\n"
      tests=tests+"\t\tend"+"\n"
      tests=tests+"\t\tassert_equal(#{test_method}(#{test_case.input}),#{test_case.expected_output})"+"\n"
      tests=tests+"\tend\n\n"
      
      elsif language=='Python'
      tests=tests+"\tdef test#{i}(self):"+"\n"
      tests=tests+"\t\tif #{base_class}.#{test_method}(#{test_case.input})==#{test_case.expected_output}:"+"\n"
      tests=tests+"\t\t\t#{base_class}Test.f.write(\"1,,#{i}\\n\")"+"\n"+"\t\telse:\n"
      tests=tests+"\t\t\t#{base_class}Test.f.write(\"0,"+test_case.negative_feedback+','+i.to_s+'\n")'+"\n"
      tests=tests+"\t\tself.assertEqual(#{base_class}.#{test_method}(#{test_case.input}),#{test_case.expected_output})"+"\n\n"
      end
    end
    return tests
  end
  
  
end
