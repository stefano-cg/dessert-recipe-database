--Creating our recipe table
DROP TABLE dessert_recipes;
CREATE TABLE dessert_recipes (
    id INTEGER PRIMARY KEY,
    recipe_name VARCHAR2(50) NOT NULL,
    recipe_description VARCHAR2(50)
);
--Creating a sequence to properly id our recipes
DROP SEQUENCE dessert_recipes_id_seq;
CREATE SEQUENCE dessert_recipes_id_seq
START WITH 1
INCREMENT BY 1;

--Creating our ingredients table
DROP TABLE ingredients;
CREATE TABLE ingredients (
    id INTEGER PRIMARY KEY,
    ingredient_name VARCHAR2(30) UNIQUE NOT NULL
);
--Creating a sequence to properly id our ingredients
DROP SEQUENCE ingredients_id_seq;
CREATE SEQUENCE ingredients_id_seq
START WITH 1
INCREMENT BY 1;

--Creating a table for the ingredients of each recipe
DROP TABLE recipe_ingredients;
CREATE TABLE recipe_ingredients (
    recipe_id INTEGER REFERENCES dessert_recipes(id) ON DELETE CASCADE,
    ingredient_id INTEGER REFERENCES ingredients(id) ON DELETE SET NULL,
    ingredient_quantity NUMBER(5) NOT NULL,
    ingredient_unit VARCHAR2(20) DEFAULT NULL,
    CONSTRAINT recipe_ingredients_pk PRIMARY KEY (recipe_id, ingredient_id)
);

--Let's prepare the recipe for Lime Posset!
INSERT INTO dessert_recipes
VALUES (dessert_recipes_id_seq.NEXTVAL, 'Lime Posset',
    'A refreshing summer dessert!');

--Let's try adding some ingredients!
INSERT INTO ingredients
VALUES (ingredients_id_seq.NEXTVAL, 'Lime');
INSERT INTO recipe_ingredients
VALUES (dessert_recipes_id_seq.CURRVAL, ingredients_id_seq.CURRVAL, 4, NULL);

INSERT INTO ingredients
VALUES (ingredients_id_seq.NEXTVAL, 'White Sugar');
INSERT INTO recipe_ingredients
VALUES (dessert_recipes_id_seq.CURRVAL, ingredients_id_seq.CURRVAL, 113, 'grams');

INSERT INTO ingredients
VALUES (ingredients_id_seq.NEXTVAL, 'Salt');
INSERT INTO recipe_ingredients
VALUES (dessert_recipes_id_seq.CURRVAL, ingredients_id_seq.CURRVAL, 1, 'pinch');

INSERT INTO ingredients
VALUES (ingredients_id_seq.NEXTVAL, 'Heavy Cream');
INSERT INTO recipe_ingredients
VALUES (dessert_recipes_id_seq.CURRVAL, ingredients_id_seq.CURRVAL, 500, 'grams');

--Let's find the ingredients
SELECT des.recipe_name, 
    rein.ingredient_quantity, rein.ingredient_unit, ing.ingredient_name
FROM dessert_recipes des
JOIN recipe_ingredients rein
ON (des.id = rein.recipe_id)
JOIN ingredients ing
ON (rein.ingredient_id = ing.id)
WHERE LOWER(des.recipe_name) = 'lime posset';
