//
//  Backstory.swift
//  
//
//  Created by Kai Quan Tay on 19/4/23.
//

import Foundation

enum Backstory: String {
    case vietnam = """
    Congrats!

    During my family's relatively short stay in Vietnam, we got to experience \
    a lot of the country's culture. As my sister and I were young children back then, \
    we were most interested in the delicious cultural food of the area.\
    <image>parents food|My mom and her friends eating at a traditional Vietnamese restaurant.</image>
    """
    case china = """
    Congrats!

    Chengdu, China, where my family lived, is famous for its pandas, among other things. However, \
    their habitats have been reduced due to infrastructure projects such as roads and railways. \
    <image>panda preservation|My sister and I at a panda preservation centre</image>\
    We visited panda preservation and research centres quite often there. I really feel that these \
    creatures should be protected as they're an important part of the region's biodiversity and culture.
    """
    case thailand = """
    Congrats!

    During my stay in Thailand I stayed quite close to the 4 faced Buddha temple at the Rachaprasong \
    junction. Visiting a temple in Thailand can be a truly immersive experience. Upon entering a \
    temple, ornate buildings, intricate carvings, and colorful statues of Buddha flank the interior. \
    Inside, you can observe monks performing religious rituals, or performers dancing to traditional
    music. \
    <image>me at temple|Me at the 4 faced buddha temple, playing one of the thai traditional instruments</image>\
    Temples in Thailand are often important cultural landmarks and tourist attractions, and made my \
    family's time there far easier.
    """
}

enum Guide: String {
    case vietnam = """
    Food is a very important part of many cultures, including Vietnam's.

    The player must use their finger to move a bowl of bun cha \
    (Vietnamese noodles with grilled pork) around a maze, collecting \
    correct ingredients and avoiding wrong ingredients.

    To move the bowl, drag your finger around the screen. As you drag your \
    finger around the screen, the noodle bowl will move accordingly.

    Make your way to the end of the maze. All of the correct ingredients \
    lay along the correct path, and all the wrong ingredients lay on incorrect paths.

    Similar to how my family had little time in each country, you will have a 30 second timer.
    """
    case china = """
    In China, infrastructure development (such as dams, roads, and railways) is increasingly \
    fragmenting and isolating panda populations.

    This development prevents pandas from finding new bamboo forests and potential mates. \
    Forest loss also reduces pandas' access to the bamboo they need to survive.
    Source: https:www.worldwildlife.org/species/giant-panda.

    To move the panda, tap anywhere on the screen. Don't get hit by the cars, trucks, busses, \
    and trains!

    Try to make it to the bamboo at the end of the ten roads, by the end of the timer.
    """
    case thailand = """
    As Thailand is a largely Buddhist culture, Buddhist structures such as temples \
    are a large part of Thailand's culture.

    Thailand has over 40,000 temples, 30,000 of which are in use. \
    During my family's stay in Thailand, we visited many such temples, including those you'll \
    see in this game.

    Here, you will travel across Thailand, learning about five of the temples that my family visited \
    during our stay in the country.

    To start the game, press the "Open first temple" button. For each of the five temples, there \
    are a few paragraphs about what it is, and a multiple-choice quiz.

    During the duration that the temple information is displayed, the 30 second timer will be \
    paused, and unpaused when you enter the quiz.
    
    Take your time :)
    """
}
