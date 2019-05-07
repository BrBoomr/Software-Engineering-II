class CoffeeRecipe{
  String name;
  String brewMethod;
  int coffeeVolumeGrams;
  String grindSize;
  int waterVolumeGrams;
  int temperature;
  List<RecipeStep> steps;

  CoffeeRecipe(this.name, this.brewMethod, this.coffeeVolumeGrams, this.grindSize, this.waterVolumeGrams, this.temperature, this.steps);
}

class RecipeStep{
  String text;
  String subtext;
  int time;

  RecipeStep(this.text, this.subtext, this.time);
}

CoffeeRecipe makeClassicRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "120 grams", 10),
    RecipeStep("Stir", "", 20),
    RecipeStep("Steep", "", 15),
    RecipeStep("Plunge", "", 15),
    ];
  CoffeeRecipe classic =CoffeeRecipe("The Classic", "Traditional", 30, "medium fine", 120, 185, steps);
  return classic;
}

CoffeeRecipe makeChargerRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "250 grams", 10),
    RecipeStep("Stir", "", 10),
    RecipeStep("Steep", "", 70),
    RecipeStep("Stir", "", 10),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Charger", "Traditional", 17, "medium fine", 250, 200, steps);
  return recipe;
}

CoffeeRecipe makeInvertedRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "120 grams", 15),
    RecipeStep("Stir", "", 15),
    RecipeStep("Steep", "", 45),
    RecipeStep("Stir", "", 15),
    RecipeStep("Stir", "", 5),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Inverted", "Inverted", 17, "medium", 120, 205, steps);
  return recipe;
}

CoffeeRecipe makeBoldRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "200 grams", 10),
    RecipeStep("Stir", "", 45),
    RecipeStep("Flip", "", 5),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Bold", "Inverted", 15, "medium fine", 200, 200, steps);
  return recipe;
}

CoffeeRecipe makeWeaverRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "100 grams", 10),
    RecipeStep("Stir", "", 25),
    RecipeStep("Pour", "120 gram", 10),
    RecipeStep("Steep", "", 25),
    RecipeStep("Flip", "", 5),
    RecipeStep("Plunge", "", 40),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Weaver", "Inverted", 15, "medium coarse", 220, 205, steps);
  return recipe;
}

CoffeeRecipe makeIcedRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "175 grams", 10),
    RecipeStep("Stir", "", 35),
    RecipeStep("Steep", "", 60),
    RecipeStep("Flip", "", 5),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Iced", "Inverted", 17, "medium fine", 175, 200, steps);
  return recipe;
}

CoffeeRecipe makeCharleneRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "175 grams", 10),
    RecipeStep("Steep", "", 20),
    RecipeStep("Pour", "175 grams", 15),
    RecipeStep("Plunge", "", 15),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Charlene", "Inverted", 18, "coarse", 250, 200, steps);
  return recipe;
}

CoffeeRecipe makeJayRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "250 grams", 10),
    RecipeStep("Stir", "", 20),
    RecipeStep("Steep", "", 30),
    RecipeStep("Flip", "", 5),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Jay", "Inverted", 17, "fine", 250, 200, steps);
  return recipe;
}

CoffeeRecipe makeCollectiveRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "170 grams", 10),
    RecipeStep("Stir", "", 15),
    RecipeStep("Steep", "", 90),
    RecipeStep("Stir", "", 15),
    RecipeStep("Flip", "", 5),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Collective", "Inverted", 30, "coarse", 170, 200, steps);
  return recipe;
}

CoffeeRecipe makeProfessorRecipe(){
  List<RecipeStep> steps = [
    RecipeStep("Pour", "170 grams", 10),
    RecipeStep("Stir", "", 15),
    RecipeStep("Steep", "", 90),
    RecipeStep("Stir", "", 15),
    RecipeStep("Flip", "", 5),
    RecipeStep("Plunge", "", 20),
    ];
  CoffeeRecipe recipe =CoffeeRecipe("The Professor", "Inverted", 30, "fine", 170, 200, steps);
  return recipe;
}

List<CoffeeRecipe> getAllRecipes(){
  return [
    makeClassicRecipe(),
    makeChargerRecipe(),
    makeInvertedRecipe(),
    makeBoldRecipe(),
    makeWeaverRecipe(),
    makeIcedRecipe(),
    makeChargerRecipe(),
    makeJayRecipe(),
    makeCollectiveRecipe(),
    makeProfessorRecipe()
  ];
}