/// <reference path="./global.d.ts" />
// @ts-check

/**
 * @param {number} [remainingTime]
 * @returns {string}
 */
export function cookingStatus(remainingTime) {
  if (remainingTime === undefined) {
    return 'You forgot to set the timer.';
  }

  if (remainingTime === 0) {
    return 'Lasagna is done.';
  }

  return 'Not done, please wait.';
}

/**
 * @param {string[]} layers
 * @param {number} [averagePreparationTime]
 * @returns {number}
 */
export function preparationTime(layers, averagePreparationTime = 2) {
  return layers.length * averagePreparationTime;
}

/**
 * @param {string[]} layers
 * @returns {{ noodles: number, sauce: number }}
 */
export function quantities(layers) {
  let noodles = 0;
  let sauce = 0;

  for (const element of layers) {
    if (element === 'noodles') {
      noodles += 50;
    } else if (element === 'sauce') {
      sauce += 0.2;
    }
  }

  return { noodles, sauce };
}

/**
 * @param {string[]} friendsList
 * @param {string[]} myList
 * @returns {void}
 */
export function addSecretIngredient(friendsList, myList) {
  myList.push(friendsList.at(-1) ?? '');
}

/**
 * @param {Record<string, number>} recipe
 * @param {number} portions
 * @returns {Record<string, number>}
 */
export function scaleRecipe(recipe, portions) {
  const factor = portions / 2;
  /** @type {Record<string, number>} */
  const scaled = {};

  for (const ingredient in recipe) {
    scaled[ingredient] = recipe[ingredient] * factor;
  }

  return scaled;
}
