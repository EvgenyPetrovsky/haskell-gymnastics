import Test.Hspec
import Zoo (whoEatsWho)

main = hspec $ do
  describe "Tests" $ do
    it "Example" $ do
      let input = "fox,bug,chicken,grass,sheep"
          expected = ["fox,bug,chicken,grass,sheep", 
                      "chicken eats bug", 
                      "fox eats chicken", 
                      "sheep eats grass", 
                      "fox eats sheep", 
                      "fox"]
      whoEatsWho input `shouldBe` expected