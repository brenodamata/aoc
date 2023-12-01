use lazy_static::lazy_static;
use regex::Regex;
use std::collections::HashMap;

lazy_static! {
  static ref NUMBER_AND_WORD_RGX: Regex = Regex::new(&format!("({}|\\d)", NUMBERS_IN_WORDS.join("|"))).unwrap();
  static ref NUMBERS_IN_WORDS: [&'static str; 10] = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];
  static ref NUMBER_WORD_TO_DIGIT: HashMap<&'static str, i32> = {
    let mut m = HashMap::new();
    for (i, word) in NUMBERS_IN_WORDS.iter().enumerate() {
      m.insert(*word, i as i32);
    }
    m
  };
}

// Function to calculate the sum based on the new logic
fn calculate_calibration_sum(input: &str) -> i32 {
  let mut sum_total = 0;

  for line in input.lines() {
    if !line.is_empty() {
      let numbers_and_words = NUMBER_AND_WORD_RGX.find_iter(line)
        .map(|mat| mat.as_str())
        .collect::<Vec<&str>>();

      if !numbers_and_words.is_empty() {
        let numbers: Vec<i32> = numbers_and_words.iter()
          .map(|&word| 
            if word.chars().all(char::is_numeric) {
              word.parse::<i32>().unwrap()
            } else {
              *NUMBER_WORD_TO_DIGIT.get(word).unwrap_or(&0)
            }
          )
          .collect();

        let two_digit_number = numbers[0] * 10 + numbers[numbers.len() - 1];
        sum_total += two_digit_number;
      }
    }
  }

  sum_total
}


fn main() {
  let input = include_str!("../../input.txt");
  let sum = calculate_calibration_sum(input);
  // let test_input = "rw1tkle0tenine\nrtwotek34one0\n3te02kfive";
  // let sum = calculate_calibration_sum(test_input);

  println!("The sum of the calibration is: {}", sum);
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn test_empty_input() {
    assert_eq!(calculate_calibration_sum(""), 0);
  }

  #[test]
  fn test_single_number_in_word() {
    assert_eq!(calculate_calibration_sum("five"), 55);
  }

  #[test]
  fn test_single_digit() {
    assert_eq!(calculate_calibration_sum("3"), 33);
  }

  #[test]
  fn test_combination_of_words_and_digits() {
    assert_eq!(calculate_calibration_sum("two 3 four"), 24);
  }

  #[test]
  fn test_multiple_lines() {
    let input = "one\ntwo\nthree\n4";
    assert_eq!(calculate_calibration_sum(input), 110);
  }

  #[test]
  fn test_multiple_lines2() {
    let input = "one22\ntwo31eekone\n2three340fiveasdf\na4asdfone"; // 12+21+25+41 = 99
    assert_eq!(calculate_calibration_sum(input), 99);
  }

  #[test]
  fn test_invalid_input() {
    assert_eq!(calculate_calibration_sum("not a number"), 0);
  }

  #[test]
  fn test_puzzle_input() {
    let input = include_str!("../../input.txt");
    assert_eq!(calculate_calibration_sum(input), 54728);
  }
}