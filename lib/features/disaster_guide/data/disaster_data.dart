import '../models/disaster_model.dart';

class DisasterData {
  
  static const List<DisasterModel> disasters = [

  

    // ================= EARTHQUAKE =================
    DisasterModel(
      emergencyTip:
"Drop, Cover, and Hold On. Stay away from windows and never use elevators during shaking.",

  id: "1",
  title: "Earthquake",
  
  description:
      "An earthquake is the sudden shaking of the Earth's surface caused by the movement of tectonic plates. It can damage buildings, roads, bridges, and utility services, causing injuries and loss of life.",

  before: [
    "Prepare an emergency kit with water, food, medicines, flashlight, batteries, and important documents.",
    "Secure heavy furniture, cupboards, mirrors, and appliances to walls.",
    "Identify safe places such as under sturdy tables or beside strong interior walls.",
    "Practice 'Drop, Cover, and Hold On' drills with your family.",
    "Learn how to switch off gas, electricity, and water supplies.",
    "Keep emergency contact numbers saved on your phone.",
    "Keep shoes and a flashlight near your bed for emergencies.",
    "Avoid placing heavy objects on high shelves.",
    "Create a family emergency communication plan.",
    "Stay informed about earthquake safety guidelines in your area.",
  ],

  during: [
    "Stay calm and do not panic.",
    "Drop to the ground, take cover under sturdy furniture, and hold on firmly.",
    "Protect your head and neck with your arms if no shelter is available.",
    "Stay away from windows, mirrors, glass doors, and heavy furniture.",
    "Do not use elevators during or immediately after shaking.",
    "If outdoors, move to an open area away from buildings, trees, streetlights, and power lines.",
    "If driving, stop in a safe open area and remain inside the vehicle until shaking stops.",
    "Do not run outside while the ground is shaking.",
    "Follow instructions from emergency officials if available.",
    "Remain alert for aftershocks after the main earthquake.",
  ],

  after: [
    "Move carefully to an open and safe location.",
    "Check yourself and others for injuries and provide first aid if trained.",
    "Call emergency services if someone is seriously injured.",
    "Expect aftershocks and stay away from damaged buildings.",
    "Check for gas leaks, damaged electrical wiring, and water pipe damage.",
    "Turn off utilities if you suspect damage and know how to do so safely.",
    "Use text messages instead of phone calls to reduce network congestion.",
    "Listen to official emergency updates using radio or mobile alerts.",
    "Avoid entering damaged buildings until authorities declare them safe.",
    "Help neighbors, elderly people, children, and persons with disabilities whenever it is safe.",
  ],

  emergencyNumber: "1070",
  image: "assets/images/earthquake.jpeg",
),
    // ================= FLOOD =================
    DisasterModel(
      emergencyTip:
"Never walk or drive through floodwater. Turn around immediately and move to higher ground.",
  id: "2",
  title: "Flood",
  description:
      "A flood is the overflow of water onto normally dry land caused by heavy rainfall, overflowing rivers, dam failure, or storms. Floods can damage homes, roads, crops, and threaten human life.",

  before: [
    "Monitor weather forecasts and official flood warnings regularly.",
    "Prepare an emergency kit with food, clean water, medicines, flashlight, batteries, and important documents.",
    "Store important documents in waterproof bags.",
    "Move electrical appliances and valuable items to higher places.",
    "Know the nearest evacuation routes and safe shelters.",
    "Keep your mobile phone and power bank fully charged.",
    "Clean drainage systems around your home.",
    "Keep emergency contact numbers easily accessible.",
    "Prepare enough drinking water and non-perishable food for several days.",
    "Keep your vehicle fueled if evacuation may become necessary.",
  ],

  during: [
    "Move immediately to higher ground when instructed.",
    "Never walk, swim, or drive through floodwater.",
    "Stay away from rivers, bridges, and fast-moving water.",
    "Switch off electricity and gas supply if it is safe to do so.",
    "Listen continuously to official weather updates and emergency instructions.",
    "Avoid contact with floodwater because it may contain sewage, chemicals, or dangerous objects.",
    "Help children, elderly people, and persons with disabilities evacuate safely.",
    "Carry only essential belongings during evacuation.",
    "Avoid using electrical equipment in flooded areas.",
    "Remain in a safe shelter until authorities declare the area safe.",
  ],

  after: [
    "Return home only after receiving official permission.",
    "Avoid entering buildings with structural damage.",
    "Drink only boiled or bottled water until the water supply is declared safe.",
    "Discard food contaminated by floodwater.",
    "Watch for snakes, insects, and other animals displaced by flooding.",
    "Avoid touching fallen electrical wires.",
    "Clean and disinfect your home carefully.",
    "Document property damage for insurance or government assistance.",
    "Seek medical attention if you develop fever, wounds, or signs of infection.",
    "Continue monitoring official updates in case of additional flooding.",
  ],

  emergencyNumber: "1070",
  image: "assets/images/flood.jpg",
),

    DisasterModel(
      emergencyTip:
"If your clothes catch fire: STOP, DROP, and ROLL. Never use elevators during a fire.",

  id: "3",
  title: "Fire",
  description:
      "A fire is the uncontrolled burning of materials that can spread rapidly, causing severe injuries, loss of life, and damage to homes, buildings, and the environment. Fires may result from electrical faults, gas leaks, cooking accidents, or natural causes.",

  before: [
    "Install smoke detectors in your home and test them regularly.",
    "Keep fire extinguishers in accessible locations and learn how to use them.",
    "Inspect electrical wiring and repair damaged cables immediately.",
    "Turn off gas cylinders and electrical appliances when not in use.",
    "Store flammable liquids, chemicals, and fuels away from heat sources.",
    "Never overload electrical sockets or extension boards.",
    "Prepare and practice a family emergency evacuation plan.",
    "Identify at least two safe exit routes from every room.",
    "Keep emergency numbers easily available for all family members.",
    "Teach children basic fire safety and emergency evacuation procedures.",
  ],

  during: [
    "Stay calm and immediately alert everyone nearby.",
    "Activate the nearest fire alarm if available.",
    "Call the Fire Service (101) immediately.",
    "Evacuate the building using the nearest safe exit.",
    "Never use elevators during a fire; always use stairs.",
    "Stay low to the ground to avoid inhaling smoke.",
    "Cover your nose and mouth with a wet cloth if possible.",
    "If trapped, close the door, block gaps with wet towels, and signal for help through a window.",
    "If your clothes catch fire, STOP, DROP, and ROLL until the flames are extinguished.",
    "Never return to retrieve personal belongings once you have evacuated.",
    "Assist children, elderly people, and persons with disabilities if it is safe to do so.",
    "Use a fire extinguisher only if the fire is small and you know how to operate it safely.",
  ],

  after: [
    "Return to the building only after authorities declare it safe.",
    "Check yourself and others for burns or injuries and seek medical assistance immediately.",
    "Avoid touching damaged electrical wiring or gas pipelines.",
    "Watch for hidden fire hotspots that could reignite.",
    "Dispose of food, medicines, and water exposed to smoke or fire damage.",
    "Photograph property damage for insurance and official reports.",
    "Report structural damage to local authorities before re-entering.",
    "Replace damaged smoke detectors, fire extinguishers, and emergency equipment.",
    "Review the incident with your family and improve your fire emergency plan.",
    "Seek emotional support if the incident caused trauma or stress.",
  ],

  emergencyNumber: "101",
  image: "assets/images/fire.jpg",
),

    DisasterModel(
      emergencyTip:
"Stay indoors, away from windows. Do not go outside during the eye of the cyclone.",

  id: "4",
  title: "Cyclone",
  description:
      "A cyclone is a powerful storm with strong winds, heavy rainfall, thunderstorms, and possible flooding. It can cause severe damage to homes, trees, power lines, and coastal areas.",

  before: [
    "Monitor weather forecasts and official cyclone warnings regularly.",
    "Prepare an emergency kit with food, water, medicines, flashlight, batteries, and important documents.",
    "Charge mobile phones and power banks before the cyclone arrives.",
    "Keep emergency contact numbers readily available.",
    "Secure doors, windows, roofs, and outdoor objects that may become dangerous in strong winds.",
    "Trim weak tree branches around your house.",
    "Store enough drinking water and non-perishable food for several days.",
    "Identify the nearest cyclone shelter and evacuation routes.",
    "Keep your vehicle fueled if evacuation becomes necessary.",
    "Follow evacuation orders immediately if issued by local authorities.",
  ],

  during: [
    "Stay indoors and keep away from windows, glass doors, and balconies.",
    "Close all doors and windows securely.",
    "Switch off electricity and gas supply if flooding is expected.",
    "Do not go outside during the eye of the cyclone as dangerous winds can return suddenly.",
    "Listen to official weather updates through radio or mobile alerts.",
    "Avoid driving unless absolutely necessary.",
    "Stay away from beaches, rivers, and flooded roads.",
    "Use flashlights instead of candles to reduce fire risk.",
    "Keep children and elderly family members in the safest room of the house.",
    "Remain calm until authorities announce that the cyclone has completely passed.",
  ],

  after: [
    "Leave your shelter only after receiving official clearance.",
    "Avoid damaged buildings, fallen trees, and broken electrical wires.",
    "Do not touch flooded electrical equipment.",
    "Check family members for injuries and provide first aid if required.",
    "Use only clean or boiled drinking water.",
    "Avoid floodwater as it may contain dangerous debris or harmful bacteria.",
    "Report damaged power lines, gas leaks, or blocked roads to local authorities.",
    "Document property damage for insurance purposes.",
    "Help neighbors, especially elderly people and children, if it is safe to do so.",
    "Continue following official updates as flooding and strong winds may continue after the cyclone.",
  ],

  emergencyNumber: "1070",
  image: "assets/images/cyclone.jpg",
),

    DisasterModel(
      emergencyTip:
"After a strong coastal earthquake, move immediately to higher ground without waiting for official warnings.",

  id: "5",
  title: "Tsunami",
  description:
      "A tsunami is a series of large ocean waves caused by underwater earthquakes, volcanic eruptions, or landslides. Tsunamis can flood coastal areas within minutes, causing severe destruction and loss of life.",

  before: [
    "Know whether you live or work in a tsunami-prone coastal area.",
    "Learn the nearest evacuation routes and safe high-ground locations.",
    "Prepare an emergency kit with food, water, medicines, flashlight, batteries, and important documents.",
    "Keep emergency contact numbers easily accessible.",
    "Monitor earthquake and tsunami warnings from official authorities.",
    "Practice evacuation drills with your family.",
    "Charge mobile phones and power banks before severe weather events.",
    "Store enough drinking water and non-perishable food for several days.",
    "Know the warning signs such as strong earthquakes or a sudden sea withdrawal.",
    "Keep your vehicle ready in case evacuation becomes necessary.",
  ],

  during: [
    "Immediately move to higher ground after a strong earthquake or tsunami warning.",
    "Do not wait to see the tsunami wave before evacuating.",
    "Stay away from beaches, rivers, harbors, and coastal areas.",
    "Follow designated evacuation routes and instructions from emergency officials.",
    "Help children, elderly people, and persons with disabilities evacuate safely.",
    "Do not return to collect personal belongings.",
    "If you are on a boat in deep water, remain offshore if instructed by authorities.",
    "Avoid driving through flooded roads whenever possible.",
    "Listen continuously to emergency radio or official alerts.",
    "Stay in a safe location until authorities confirm the danger has passed.",
  ],

  after: [
    "Return home only after authorities declare the area safe.",
    "Beware of multiple tsunami waves, as additional waves may arrive hours later.",
    "Avoid standing floodwater because it may contain debris, sewage, or live electrical wires.",
    "Check yourself and others for injuries and provide first aid if needed.",
    "Drink only clean or boiled water.",
    "Inspect buildings carefully before entering them.",
    "Report damaged roads, bridges, and utility lines to local authorities.",
    "Photograph property damage for insurance purposes.",
    "Dispose of contaminated food and drinking water.",
    "Continue following official updates for possible aftershocks or additional tsunami warnings.",
  ],

  emergencyNumber: "1070",
  image: "assets/images/tsunami.jpg",
),

    DisasterModel(
      emergencyTip:
"Drink water frequently even if you are not thirsty. Avoid going outside between 11 AM and 4 PM.",

  id: "6",
  title: "Heatwave",
  description:
      "A heatwave is a prolonged period of extremely high temperatures that can cause dehydration, heat exhaustion, heatstroke, and other serious health problems. Children, elderly people, and those with medical conditions are at the highest risk.",

  before: [
    "Check daily weather forecasts and heatwave warnings.",
    "Keep enough drinking water stored at home.",
    "Wear light-colored, loose-fitting cotton clothing.",
    "Keep ORS packets and basic medicines ready.",
    "Ensure fans, coolers, or air conditioners are working properly.",
    "Avoid planning outdoor activities during the hottest hours of the day.",
    "Prepare hats, umbrellas, and sunscreen before going outside.",
    "Know the symptoms of heat exhaustion and heatstroke.",
    "Keep emergency contact numbers readily available.",
    "Take extra care of elderly family members, children, and pets.",
  ],

  during: [
    "Drink plenty of water even if you do not feel thirsty.",
    "Stay indoors between 11:00 AM and 4:00 PM whenever possible.",
    "Wear light-colored, loose-fitting clothing.",
    "Use fans, coolers, or air conditioning to stay cool.",
    "Avoid strenuous physical activities and outdoor work.",
    "Wear a hat, sunglasses, and use an umbrella when outside.",
    "Eat light, fresh, and water-rich foods like fruits and vegetables.",
    "Never leave children, elderly people, or pets inside parked vehicles.",
    "If someone shows signs of heatstroke, move them to a cool place and seek immediate medical help.",
    "Follow official heatwave advisories issued by local authorities.",
  ],

  after: [
    "Continue drinking plenty of fluids to stay hydrated.",
    "Monitor yourself and family members for signs of dehydration or illness.",
    "Rest if you experience dizziness, weakness, or excessive fatigue.",
    "Replace lost electrolytes using ORS or recommended drinks if necessary.",
    "Check on elderly neighbors and vulnerable people in your community.",
    "Restock emergency supplies such as drinking water and medicines.",
    "Inspect electrical appliances that may have overheated during the heatwave.",
    "Continue following weather updates, as another heatwave may occur.",
    "Seek medical attention if heat-related symptoms continue.",
    "Review your family's heat safety plan and improve it for future heatwaves.",
  ],

  emergencyNumber: "108",
  image: "assets/images/heatwaves.jpg",
),

    DisasterModel(
      emergencyTip:
"Move immediately away from slopes and river valleys if you notice cracks, falling rocks, or unusual sounds.",

  id: "7",
  title: "Landslide",
  description:
      "A landslide is the rapid movement of rock, soil, and debris down a slope caused by heavy rainfall, earthquakes, volcanic activity, or human activities. Landslides can destroy homes, roads, bridges, and pose serious risks to life.",

  before: [
    "Know whether your home or workplace is located in a landslide-prone area.",
    "Monitor weather forecasts, especially during heavy rainfall.",
    "Observe warning signs such as cracks in the ground, leaning trees, or unusual water flow.",
    "Prepare an emergency kit with food, water, medicines, flashlight, batteries, and important documents.",
    "Identify safe evacuation routes and nearby shelters.",
    "Avoid building or camping near steep slopes or unstable hillsides.",
    "Ensure proper drainage around your home to reduce water accumulation.",
    "Keep emergency contact numbers easily accessible.",
    "Educate family members about landslide warning signs and evacuation procedures.",
    "Be prepared to evacuate immediately if authorities issue a warning.",
  ],

  during: [
    "Move immediately to higher and safer ground away from the landslide path.",
    "Stay away from river channels, valleys, and steep slopes.",
    "Do not attempt to cross flowing mud or debris.",
    "If indoors, leave the building only if it is safe to do so.",
    "Protect your head and neck if escape is not possible.",
    "Listen to emergency broadcasts and follow official instructions.",
    "Avoid driving through affected roads or bridges.",
    "Help children, elderly people, and persons with disabilities evacuate safely.",
    "Watch for falling rocks, trees, power lines, and other hazards.",
    "Remain in a safe location until authorities declare the area secure.",
  ],

  after: [
    "Return home only after receiving official permission.",
    "Stay alert for additional landslides, especially after heavy rainfall.",
    "Avoid damaged buildings, roads, bridges, and unstable slopes.",
    "Report broken gas lines, water pipes, and electrical cables immediately.",
    "Check yourself and others for injuries and provide first aid if necessary.",
    "Use only safe drinking water and avoid contaminated sources.",
    "Document property damage for insurance and recovery purposes.",
    "Help neighbors if it is safe to do so.",
    "Continue monitoring official weather and emergency updates.",
    "Review your emergency preparedness plan for future landslide risks.",
  ],

  emergencyNumber: "1070",
  image: "assets/images/landslide.jpg",
),

 DisasterModel(
  emergencyTip:
"When thunder roars, go indoors. Stay inside for at least 30 minutes after the last thunder.",

  id: "8",
  title: "Lightning",
  description:
      "Lightning is a powerful electrical discharge during thunderstorms. It can cause severe injuries, fires, power outages, and even death. Staying indoors and following safety precautions can greatly reduce the risk.",

  before: [
    "Check weather forecasts for thunderstorm warnings.",
    "Identify a safe building or enclosed vehicle for shelter.",
    "Keep emergency kits, flashlights, and power banks ready.",
    "Unplug sensitive electrical appliances if severe storms are expected.",
    "Avoid planning outdoor activities during thunderstorms.",
    "Educate family members about lightning safety rules.",
    "Store emergency contact numbers on your phone.",
    "Ensure mobile devices are fully charged before the storm.",
    "Stay informed through weather alerts and emergency notifications.",
    "Prepare first aid supplies for possible emergencies.",
  ],

  during: [
    "Immediately move indoors when you hear thunder.",
    "Stay away from windows, doors, and balconies.",
    "Do not use wired electrical appliances or landline telephones.",
    "Avoid taking showers or using running water during the storm.",
    "Stay away from metal objects, fences, poles, and trees.",
    "If caught outside, avoid open fields and isolated trees.",
    "If no shelter is available, crouch low with your feet together and keep your head down.",
    "Do not lie flat on the ground.",
    "Remain indoors for at least 30 minutes after the last thunder.",
    "Follow official weather updates until the storm passes.",
  ],

  after: [
    "Check family members for injuries and provide first aid if necessary.",
    "Call emergency services immediately if someone is struck by lightning.",
    "Inspect your home for fire, electrical damage, or fallen power lines.",
    "Avoid touching damaged electrical equipment.",
    "Stay away from flooded areas containing electrical hazards.",
    "Report damaged power lines to local authorities.",
    "Replace damaged emergency supplies if needed.",
    "Continue monitoring weather updates for additional storms.",
    "Help neighbors if it is safe to do so.",
    "Review lightning safety procedures with your family for future storms.",
  ],

  emergencyNumber: "108",
  image: "assets/images/lightning.jpg",
),

   DisasterModel(
    emergencyTip:
"Stay indoors and avoid using wired electrical devices, plumbing, or standing near windows.",

  id: "9",
  title: "Thunderstorm",
  description:
      "A thunderstorm is a weather event involving heavy rain, thunder, lightning, strong winds, and sometimes hail. It can cause flooding, fallen trees, power outages, and damage to buildings.",

  before: [
    "Monitor weather forecasts and thunderstorm warnings.",
    "Prepare an emergency kit with food, water, medicines, flashlight, and batteries.",
    "Charge your mobile phone and power bank.",
    "Secure loose outdoor furniture and objects.",
    "Close and lock all windows and doors.",
    "Trim weak tree branches around your house.",
    "Keep emergency contact numbers easily accessible.",
    "Identify a safe room inside your home.",
    "Avoid planning outdoor activities if storms are expected.",
    "Keep important documents in a waterproof bag.",
  ],

  during: [
    "Stay indoors and avoid going outside.",
    "Keep away from windows, glass doors, and balconies.",
    "Do not shelter under trees or near electric poles.",
    "Avoid using wired electrical appliances and landline phones.",
    "Do not touch metal objects or electrical equipment.",
    "Stay away from rivers, lakes, and flooded areas.",
    "If driving, stop safely away from trees and power lines.",
    "Use flashlights instead of candles during power outages.",
    "Listen to official weather updates and emergency alerts.",
    "Remain indoors until authorities confirm the storm has passed.",
  ],

  after: [
    "Check family members for injuries and provide first aid if necessary.",
    "Stay away from fallen power lines and report them immediately.",
    "Inspect your home for structural damage.",
    "Avoid flooded roads and damaged bridges.",
    "Check gas and electrical connections before using them.",
    "Clean up fallen branches and debris only when it is safe.",
    "Replace damaged emergency supplies.",
    "Continue monitoring weather updates for additional storms.",
    "Help neighbors, especially elderly people and children, if safe.",
    "Document property damage for insurance purposes.",
  ],

  emergencyNumber: "108",
  image: "assets/images/thunderstorm.jpg",
),

   DisasterModel(
    emergencyTip:
"Wear a mask and goggles to protect yourself from volcanic ash, and stay indoors if possible.",

  id: "10",
  title: "Volcanic Eruption",
  description:
      "A volcanic eruption occurs when magma, ash, and gases are released from a volcano. It can cause lava flows, ashfall, toxic gases, landslides, and severe damage to nearby communities.",

  before: [
    "Know whether you live near an active volcano.",
    "Prepare an emergency kit with food, water, masks, medicines, flashlight, and batteries.",
    "Store important documents in waterproof bags.",
    "Keep N95 masks and goggles ready to protect against volcanic ash.",
    "Know evacuation routes and nearby shelters.",
    "Follow volcano monitoring updates from authorities.",
    "Keep vehicles fueled for emergency evacuation.",
    "Prepare enough drinking water for several days.",
    "Keep emergency contact numbers available.",
    "Practice evacuation plans with your family.",
  ],

  during: [
    "Evacuate immediately if instructed by authorities.",
    "Stay indoors if ash is falling heavily.",
    "Wear a mask and goggles before going outside.",
    "Close all windows, doors, and ventilation systems.",
    "Avoid river valleys where lava or mudflows may occur.",
    "Do not drive unless absolutely necessary.",
    "Protect children and elderly people from volcanic ash.",
    "Avoid touching hot lava or volcanic rocks.",
    "Listen to official emergency broadcasts.",
    "Remain in a safe place until authorities declare it safe.",
  ],

  after: [
    "Return home only after official permission.",
    "Wear a mask while cleaning volcanic ash.",
    "Remove ash carefully from roofs to prevent collapse.",
    "Avoid contaminated food and water.",
    "Check buildings for structural damage.",
    "Inspect electrical and gas systems before use.",
    "Seek medical help if you experience breathing problems.",
    "Help neighbors if it is safe.",
    "Photograph damage for insurance purposes.",
    "Continue monitoring official updates.",
  ],

  emergencyNumber: "1070",
  image: "assets/images/volcaniceruption.jpg",
),

   DisasterModel(
    emergencyTip:
"Cover your nose and mouth with a wet cloth, move away from the leak, and avoid touching spilled chemicals.",

  id: "11",
  title: "Chemical Leak",
  description:
      "A chemical leak is the accidental release of hazardous chemicals into the environment. It can cause poisoning, breathing problems, skin burns, explosions, and environmental contamination.",

  before: [
    "Know the hazardous industries located near your area.",
    "Learn emergency evacuation routes.",
    "Prepare masks, clean water, and first aid supplies.",
    "Store emergency contact numbers.",
    "Keep windows and ventilation systems in good condition.",
    "Learn the warning sirens used in your locality.",
    "Prepare an emergency kit.",
    "Educate your family about chemical hazards.",
    "Keep important medicines readily available.",
    "Follow local safety instructions and awareness programs.",
  ],

  during: [
    "Move away from the leak immediately.",
    "Cover your nose and mouth with a wet cloth or mask.",
    "Stay indoors if instructed and seal doors and windows.",
    "Turn off fans and air conditioners.",
    "Avoid touching spilled chemicals.",
    "Do not eat or drink contaminated food or water.",
    "Follow evacuation orders immediately.",
    "Assist children, elderly people, and disabled persons.",
    "Avoid driving through contaminated areas.",
    "Listen continuously to official emergency announcements.",
  ],

  after: [
    "Return only after authorities declare the area safe.",
    "Wash exposed skin thoroughly with clean water.",
    "Dispose of contaminated clothing safely.",
    "Drink only safe water.",
    "Seek immediate medical attention if exposed.",
    "Report any remaining chemical spills.",
    "Clean your home following official safety guidelines.",
    "Replace contaminated food and supplies.",
    "Continue monitoring health for delayed symptoms.",
    "Review your emergency preparedness plan.",
  ],

  emergencyNumber: "108",
  image: "assets/images/chemical1.jpg",
),

   DisasterModel(
    emergencyTip:
"Wash your hands regularly, wear a mask if advised, and isolate yourself if you develop symptoms.",

  id: "12",
  title: "Pandemic",
  description:
      "A pandemic is the worldwide spread of an infectious disease that affects large numbers of people. It can spread rapidly through human contact, causing widespread illness, disruption of daily life, and increased pressure on healthcare systems.",

  before: [
    "Stay informed through official health authorities and government announcements.",
    "Keep a first aid kit, face masks, hand sanitizer, and essential medicines at home.",
    "Maintain good personal hygiene by washing hands regularly with soap.",
    "Strengthen your immune system with healthy food, regular exercise, and adequate sleep.",
    "Store essential food, drinking water, and household supplies for emergencies.",
    "Keep important medical records and prescriptions easily accessible.",
    "Ensure all recommended vaccinations are up to date.",
    "Prepare an emergency contact list including doctors and nearby hospitals.",
    "Learn the symptoms of common infectious diseases.",
    "Create a family emergency plan in case isolation or quarantine becomes necessary.",
  ],

  during: [
    "Follow instructions issued by health authorities immediately.",
    "Wear a face mask in crowded or public places when recommended.",
    "Wash your hands frequently using soap or alcohol-based sanitizer.",
    "Avoid touching your eyes, nose, and mouth with unclean hands.",
    "Maintain physical distancing from people showing symptoms of illness.",
    "Stay home if you feel sick and avoid unnecessary travel.",
    "Cover your mouth and nose while coughing or sneezing using a tissue or your elbow.",
    "Clean and disinfect frequently touched surfaces regularly.",
    "Seek medical advice immediately if you experience severe symptoms such as breathing difficulty.",
    "Avoid spreading rumors and rely only on verified information from official sources.",
  ],

  after: [
    "Continue following public health recommendations until restrictions are officially lifted.",
    "Complete any prescribed medical treatment.",
    "Maintain healthy hygiene habits even after the outbreak.",
    "Attend follow-up medical checkups if advised by healthcare professionals.",
    "Restock emergency supplies, medicines, masks, and sanitizers.",
    "Support family members and neighbors who may need assistance.",
    "Seek emotional or mental health support if stress or anxiety persists.",
    "Review your family's emergency preparedness plan and improve it.",
    "Keep vaccination records updated for future outbreaks.",
    "Stay informed about possible future disease outbreaks and preventive measures.",
  ],

  emergencyNumber: "108",
  image: "assets/images/pandemic1.jpg",
),

   DisasterModel(
    emergencyTip:
"Wear multiple layers of warm clothing and avoid prolonged exposure to freezing temperatures.",

  id: "13",
  title: "Cold Wave",
  description:
      "A cold wave is a prolonged period of extremely low temperatures that can lead to hypothermia, frostbite, respiratory illnesses, and dangerous road conditions. Elderly people, children, and individuals with health conditions are especially vulnerable.",

  before: [
    "Monitor weather forecasts and cold wave warnings regularly.",
    "Keep sufficient warm clothing, blankets, and winter supplies ready.",
    "Stock enough food, drinking water, medicines, and emergency essentials.",
    "Ensure heaters and electrical appliances are working safely.",
    "Keep flashlights and spare batteries ready in case of power outages.",
    "Prepare an emergency kit including first aid supplies.",
    "Protect water pipes from freezing where applicable.",
    "Store emergency contact numbers in your phone.",
    "Ensure pets and livestock have warm shelter and food.",
    "Check on elderly family members and people with medical conditions regularly.",
  ],

  during: [
    "Stay indoors as much as possible.",
    "Wear multiple layers of warm clothing, gloves, scarves, and caps.",
    "Drink warm fluids and eat nutritious meals to maintain body temperature.",
    "Avoid unnecessary travel during severe cold conditions.",
    "Use heaters safely and ensure proper room ventilation.",
    "Never use charcoal grills or generators inside enclosed spaces.",
    "Watch for symptoms of hypothermia and frostbite.",
    "Keep children, elderly people, and pets warm at all times.",
    "Drive carefully as roads may become slippery due to ice or frost.",
    "Continue listening to official weather updates until conditions improve.",
  ],

  after: [
    "Inspect your home for damage caused by freezing temperatures.",
    "Check water pipes, electrical systems, and heating equipment.",
    "Seek medical attention if anyone experiences prolonged cold-related illness.",
    "Replace emergency supplies that were used during the cold wave.",
    "Continue wearing warm clothing until temperatures return to normal.",
    "Help vulnerable neighbors and community members if needed.",
    "Document any property damage for insurance purposes.",
    "Review your emergency preparedness plan for future cold weather.",
    "Maintain proper nutrition and hydration while recovering.",
    "Stay informed about possible additional cold weather warnings.",
  ],

  emergencyNumber: "108",
  image: "assets/images/coldwave1.jpg",
),

    DisasterModel(
      emergencyTip:
"Stay indoors, conserve body heat, and avoid travelling until weather conditions improve.",

  id: "14",
  title: "Snowstorm / Blizzard",
  description:
      "A snowstorm or blizzard is a severe winter storm with heavy snowfall, strong winds, and extremely low visibility. It can block roads, damage power lines, and create dangerous freezing conditions.",

  before: [
    "Monitor weather forecasts and blizzard warnings regularly.",
    "Prepare enough food, drinking water, medicines, and warm clothing.",
    "Keep flashlights, batteries, power banks, and blankets ready.",
    "Ensure heating systems are working properly.",
    "Keep your vehicle fueled and equipped with emergency supplies.",
    "Charge all mobile devices before the storm arrives.",
    "Store emergency contact numbers.",
    "Keep important documents in waterproof storage.",
    "Prepare a first aid kit and emergency medicines.",
    "Plan safe shelter locations if evacuation becomes necessary.",
  ],

  during: [
    "Stay indoors and avoid unnecessary travel.",
    "Keep doors and windows closed to preserve heat.",
    "Wear multiple layers of warm clothing.",
    "Use heaters safely with proper ventilation.",
    "Avoid touching frozen electrical wires.",
    "Drink warm fluids and eat nutritious food.",
    "Keep listening to official weather updates.",
    "Avoid driving unless absolutely necessary.",
    "Check on elderly family members and neighbors.",
    "Call emergency services if anyone shows signs of hypothermia.",
  ],

  after: [
    "Clear snow carefully to avoid injuries.",
    "Inspect your home for structural damage.",
    "Watch for fallen power lines.",
    "Drive carefully as roads may remain icy.",
    "Restock emergency supplies.",
    "Check water pipes for freezing damage.",
    "Seek medical attention for cold-related illnesses.",
    "Help neighbors if safe to do so.",
    "Continue monitoring weather updates.",
    "Review your emergency preparedness plan.",
  ],

  emergencyNumber: "108",
  image: "assets/images/snow.jpg",
),

    DisasterModel(
      emergencyTip:
"Go to the lowest floor and protect your head. Stay away from windows and exterior walls.",

  id: "15",
  title: "Tornado",
  description:
      "A tornado is a rapidly rotating column of air extending from a thunderstorm to the ground. Tornadoes produce extremely strong winds capable of destroying buildings, uprooting trees, and throwing debris over long distances.",

  before: [
    "Monitor tornado watches and warnings issued by authorities.",
    "Identify the safest room in your home, preferably a basement or an interior room.",
    "Prepare an emergency kit with food, water, medicines, flashlight, batteries, and important documents.",
    "Charge mobile phones and power banks.",
    "Secure outdoor furniture and loose objects.",
    "Practice tornado evacuation drills with your family.",
    "Keep emergency contact numbers readily available.",
    "Know the nearest community storm shelter.",
    "Prepare sturdy shoes and helmets for protection.",
    "Stay informed through weather radio or official alerts.",
  ],

  during: [
    "Immediately move to the lowest floor of a strong building.",
    "Stay away from windows, doors, and glass objects.",
    "Protect your head and neck using a helmet, mattress, or heavy blanket.",
    "Do not stay inside vehicles or mobile homes.",
    "If outdoors, seek shelter in a sturdy building immediately.",
    "Avoid bridges and overpasses.",
    "Remain calm and listen to emergency broadcasts.",
    "Do not open windows.",
    "Stay in your shelter until authorities declare it safe.",
    "Assist children, elderly people, and disabled persons.",
  ],

  after: [
    "Watch for fallen power lines and gas leaks.",
    "Avoid damaged buildings until inspected.",
    "Provide first aid to injured people if safe.",
    "Report emergencies to local authorities.",
    "Use flashlights instead of candles.",
    "Avoid driving through debris-covered roads.",
    "Photograph property damage for insurance.",
    "Drink only clean water.",
    "Help neighbors if safe.",
    "Continue following official updates.",
  ],

  emergencyNumber: "1070",
  image: "assets/images/tornado1.jpg",
),

   DisasterModel(
    emergencyTip:
"Call emergency services immediately and never move seriously injured victims unless they are in immediate danger.",

  id: "16",
  title: "Road Accident",
  description:
      "A road accident occurs when vehicles, pedestrians, or cyclists collide due to speeding, poor road conditions, distracted driving, or traffic violations. Quick action can save lives and prevent further injuries.",

  before: [
    "Always wear a seatbelt or helmet while travelling.",
    "Follow traffic rules and speed limits.",
    "Avoid using mobile phones while driving.",
    "Never drive under the influence of alcohol or drugs.",
    "Maintain your vehicle regularly, including brakes and tires.",
    "Keep a first aid kit and emergency tools in your vehicle.",
    "Carry important emergency contact numbers.",
    "Drive carefully during rain, fog, or poor visibility.",
    "Avoid driving when tired or sleepy.",
    "Plan your route before starting your journey.",
  ],

  during: [
    "Stay calm and assess the situation.",
    "Turn on hazard lights to warn other vehicles.",
    "Move to a safe location if possible.",
    "Call emergency services immediately (108).",
    "Provide first aid only if you are trained.",
    "Do not move seriously injured victims unless there is immediate danger.",
    "Stop fuel leaks or fire hazards if safe.",
    "Warn approaching traffic using warning triangles or flashlights.",
    "Remain with injured persons until help arrives.",
    "Cooperate with emergency responders and police.",
  ],

  after: [
    "Seek medical attention even for minor injuries.",
    "Report the accident to the police and insurance company.",
    "Document the accident with photographs if safe.",
    "Exchange details with other drivers involved.",
    "Check your vehicle before driving again.",
    "Replace damaged safety equipment.",
    "Follow medical advice for recovery.",
    "Support injured family members emotionally.",
    "Review the cause of the accident to improve future safety.",
    "Continue following traffic regulations.",
  ],

  emergencyNumber: "108",
  image: "assets/images/roadaccident1.jpg",
),

   DisasterModel(
    emergencyTip:
"Leave the train only when instructed or if there is immediate danger. Stay away from railway tracks.",

  id: "17",
  title: "Train Accident",
  description:
      "A train accident may occur due to derailment, collision, fire, or mechanical failure. Remaining calm and following emergency instructions greatly increases the chances of survival.",

  before: [
    "Know the location of emergency exits in your train coach.",
    "Keep luggage securely stored.",
    "Carry essential medicines and identification documents.",
    "Memorize emergency contact numbers.",
    "Avoid standing near train doors unnecessarily.",
    "Never board or exit a moving train.",
    "Follow railway safety instructions.",
    "Keep your mobile phone charged.",
    "Carry a flashlight during long-distance travel.",
    "Stay aware of emergency announcements.",
  ],

  during: [
    "Stay calm and avoid panic.",
    "Hold firmly to seats or handrails if the train suddenly stops.",
    "Follow railway staff instructions immediately.",
    "Use emergency exits only if instructed.",
    "Move away from damaged coaches carefully.",
    "Avoid touching electrical wires or damaged equipment.",
    "Help children, elderly people, and injured passengers.",
    "Call emergency services if possible.",
    "Do not return to collect luggage.",
    "Move to a safe distance from the railway tracks.",
  ],

  after: [
    "Receive medical attention immediately if injured.",
    "Stay away from damaged railway tracks.",
    "Cooperate with rescue teams.",
    "Inform your family about your safety.",
    "Report missing passengers if necessary.",
    "Avoid spreading false information.",
    "Document personal belongings if required.",
    "Follow official railway announcements.",
    "Support injured passengers if it is safe.",
    "Wait until authorities declare the area safe.",
  ],

  emergencyNumber: "139",
  image: "assets/images/train1.jpg",
),
    
    DisasterModel(
      emergencyTip:
"Leave all luggage behind and evacuate using the nearest safe exit immediately.",

  id: "18",
  title: "Airplane Accident",
  description:
      "An airplane accident is an emergency involving an aircraft during takeoff, flight, or landing. Following crew instructions and remaining calm greatly improves the chances of survival.",

  before: [
    "Pay close attention to the safety demonstration before takeoff.",
    "Locate the nearest emergency exits and count the rows to reach them.",
    "Fasten your seatbelt whenever seated.",
    "Keep your carry-on baggage properly secured.",
    "Read the aircraft safety information card.",
    "Keep your mobile phone in airplane mode when instructed.",
    "Wear comfortable clothing and closed shoes.",
    "Carry essential medicines in your hand luggage.",
    "Follow all instructions given by the cabin crew.",
    "Avoid carrying prohibited or dangerous items.",
  ],

  during: [
    "Remain calm and follow cabin crew instructions immediately.",
    "Keep your seatbelt securely fastened.",
    "Adopt the recommended brace position when instructed.",
    "Leave all personal belongings behind during evacuation.",
    "Use the nearest safe emergency exit.",
    "Inflate your life jacket only after leaving the aircraft if over water.",
    "Move quickly away from the aircraft after evacuation.",
    "Help children, elderly people, and injured passengers if it is safe.",
    "Avoid blocking emergency exits.",
    "Stay together with your group in the designated safe area.",
  ],

  after: [
    "Move at least 200 meters away from the aircraft.",
    "Call emergency services if possible.",
    "Provide first aid to injured passengers if trained.",
    "Stay away from smoke, fire, or leaking fuel.",
    "Follow rescue team instructions.",
    "Do not re-enter the aircraft.",
    "Keep yourself warm while waiting for rescue.",
    "Report missing passengers to rescuers.",
    "Cooperate with investigators if requested.",
    "Contact family members once you are safe.",
  ],

  emergencyNumber: "112",
  image: "assets/images/airoplain1.jpg",
),

   DisasterModel(
    emergencyTip:
"Move away from smoke and fire immediately. Never try to outrun a fast-moving wildfire uphill.",

  id: "19",
  title: "Forest Fire",
  description:
      "A forest fire is an uncontrolled wildfire that spreads rapidly through forests, grasslands, or vegetation. Strong winds, dry weather, and high temperatures can cause fires to spread quickly, threatening people, wildlife, and property.",

  before: [
    "Check forest fire warnings before visiting forest areas.",
    "Avoid lighting campfires during dry seasons.",
    "Never throw burning cigarettes into forests.",
    "Prepare an emergency evacuation plan.",
    "Keep emergency supplies and drinking water ready.",
    "Know nearby evacuation routes and shelters.",
    "Store emergency contact numbers.",
    "Wear protective clothing when entering forest areas.",
    "Keep vehicles fueled for quick evacuation.",
    "Report any signs of smoke or fire immediately.",
  ],

  during: [
    "Evacuate immediately if authorities issue an evacuation order.",
    "Move away from the direction of the fire and smoke.",
    "Cover your nose and mouth with a wet cloth or mask.",
    "Stay low to avoid inhaling smoke.",
    "Do not attempt to fight large fires.",
    "Avoid driving through dense smoke.",
    "Close windows and doors if sheltering indoors.",
    "Listen to official emergency announcements.",
    "Help children, elderly people, and pets evacuate safely.",
    "Call emergency services immediately if trapped.",
  ],

  after: [
    "Return only after authorities declare the area safe.",
    "Watch for burning trees, hot ash, and hidden embers.",
    "Avoid damaged power lines and structures.",
    "Wear a mask while cleaning ash.",
    "Check your property for fire damage.",
    "Use safe drinking water only.",
    "Report any remaining fire or smoke.",
    "Seek medical attention for breathing difficulties.",
    "Photograph property damage for insurance claims.",
    "Review your emergency plan for future wildfire seasons.",
  ],

  emergencyNumber: "101",
  image: "assets/images/forestfire.jpg",
),

   DisasterModel(
    emergencyTip:
"Activate the emergency alarm, evacuate immediately, and avoid hazardous materials or smoke.",

  id: "20",
  title: "Industrial Accident",
  description:
      "An industrial accident is an unexpected event in factories, warehouses, construction sites, or manufacturing plants that may involve explosions, fires, equipment failure, hazardous materials, or structural collapse. Quick response can reduce injuries and save lives.",

  before: [
    "Follow all workplace safety rules and regulations.",
    "Wear appropriate Personal Protective Equipment (PPE).",
    "Know emergency exits and evacuation routes.",
    "Participate in regular safety training and emergency drills.",
    "Report damaged equipment immediately.",
    "Keep emergency numbers easily accessible.",
    "Know the location of fire extinguishers and first aid kits.",
    "Store hazardous materials safely.",
    "Avoid unauthorized access to restricted areas.",
    "Always inspect machinery before use.",
  ],

  during: [
    "Stay calm and avoid panic.",
    "Activate the nearest emergency alarm.",
    "Follow the factory evacuation procedure immediately.",
    "Do not use elevators during evacuation.",
    "Move to the designated assembly point.",
    "Help injured coworkers only if it is safe.",
    "Avoid hazardous chemical spills and smoke.",
    "Switch off machinery if instructed and safe.",
    "Call emergency services immediately.",
    "Follow instructions from emergency responders.",
  ],

  after: [
    "Do not return until authorities declare the area safe.",
    "Receive medical attention for any injuries.",
    "Report the incident to supervisors.",
    "Cooperate during the investigation.",
    "Inspect equipment before restarting operations.",
    "Replace damaged safety equipment.",
    "Provide emotional support to affected workers.",
    "Document damages if required.",
    "Participate in safety reviews.",
    "Improve workplace safety procedures.",
  ],

  emergencyNumber: "112",
  image: "assets/images/industry.jpg",
),

   DisasterModel(
    emergencyTip:
"Go indoors immediately, close all doors and windows, and follow official instructions carefully.",

  id: "21",
  title: "Radiation Emergency",
  description:
      "A radiation emergency occurs when harmful radioactive materials are released due to nuclear accidents, transportation incidents, or industrial failures. Radiation cannot be seen or smelled, making official guidance extremely important.",

  before: [
    "Know whether you live near a nuclear facility.",
    "Learn local evacuation and shelter plans.",
    "Prepare an emergency kit with food, water, medicines, flashlight, and radio.",
    "Store emergency contact numbers.",
    "Know the nearest emergency shelter.",
    "Keep important documents waterproof.",
    "Follow official emergency preparedness guidance.",
    "Prepare enough supplies for several days.",
    "Understand radiation warning signals.",
    "Keep battery-powered communication devices ready.",
  ],

  during: [
    "Immediately move indoors if instructed.",
    "Close all windows, doors, and ventilation systems.",
    "Stay inside until authorities give further instructions.",
    "Avoid consuming exposed food or water.",
    "Remove contaminated clothing carefully if exposed.",
    "Wash exposed skin thoroughly using soap and water.",
    "Do not leave shelter unless instructed.",
    "Listen continuously to official emergency broadcasts.",
    "Avoid entering restricted areas.",
    "Remain calm and follow government instructions.",
  ],

  after: [
    "Return outside only after official clearance.",
    "Dispose of contaminated clothing safely if instructed.",
    "Seek medical examination if exposure is suspected.",
    "Drink only approved safe water.",
    "Avoid contaminated food sources.",
    "Continue monitoring official announcements.",
    "Document exposure details for healthcare providers.",
    "Support affected family members emotionally.",
    "Restock emergency supplies.",
    "Review emergency preparedness for future incidents.",
  ],

  emergencyNumber: "112",
  image: "assets/images/radiation.jpg",
),

   DisasterModel(
    emergencyTip:
"Move to higher ground immediately. Do not attempt to cross rapidly flowing floodwater.",

  id: "22",
  title: "Dam Failure",
  description:
      "A dam failure occurs when a dam is damaged or collapses, releasing a massive amount of water. This can cause sudden flooding, destruction of homes, roads, bridges, and serious loss of life downstream.",

  before: [
    "Know whether your area is located downstream of a dam.",
    "Learn evacuation routes and nearby safe shelters.",
    "Prepare an emergency kit with food, water, medicines, flashlight, and important documents.",
    "Store emergency contact numbers.",
    "Monitor heavy rainfall and official flood warnings.",
    "Keep your mobile phone fully charged.",
    "Practice evacuation plans with your family.",
    "Identify higher ground near your location.",
    "Keep vehicles fueled for emergency evacuation.",
    "Stay informed through official disaster alerts.",
  ],

  during: [
    "Evacuate immediately when authorities issue warnings.",
    "Move quickly to higher ground.",
    "Never attempt to cross fast-moving floodwater.",
    "Avoid bridges that may be weakened by water.",
    "Turn off electricity and gas if time permits.",
    "Help children, elderly people, and disabled persons evacuate.",
    "Carry only essential belongings.",
    "Listen continuously to official emergency announcements.",
    "Avoid driving through flooded roads.",
    "Stay away from rivers and damaged dam structures.",
  ],

  after: [
    "Return home only after authorities declare the area safe.",
    "Avoid contaminated floodwater.",
    "Inspect buildings for structural damage.",
    "Check electrical systems before switching on power.",
    "Use only safe drinking water.",
    "Document property damage for insurance.",
    "Report damaged infrastructure.",
    "Seek medical attention if injured.",
    "Restock emergency supplies.",
    "Review your family's emergency preparedness plan.",
  ],

  emergencyNumber: "1070",
  image: "assets/images/dam1.jpg",
),

   DisasterModel(
    emergencyTip:
"Wear your life jacket immediately and stay with the group unless instructed otherwise.",

  id: "23",
  title: "Boat / Ship Accident",
  description:
      "Boat and ship accidents may occur due to storms, collisions, equipment failure, fire, or overloading. Following safety procedures and using life-saving equipment greatly increases survival chances.",

  before: [
    "Check weather forecasts before travelling by boat.",
    "Always wear a properly fitted life jacket.",
    "Know the location of life rafts and emergency exits.",
    "Avoid overloading the boat.",
    "Keep emergency contact numbers available.",
    "Carry waterproof communication devices if possible.",
    "Follow all safety instructions from the crew.",
    "Ensure children always wear life jackets.",
    "Keep emergency supplies on board.",
    "Learn basic water survival techniques.",
  ],

  during: [
    "Remain calm and avoid panic.",
    "Wear your life jacket immediately.",
    "Follow instructions from the captain or crew.",
    "Move to designated emergency assembly points.",
    "Do not jump into the water unless instructed.",
    "Stay together with other passengers.",
    "Use emergency rafts if evacuation becomes necessary.",
    "Avoid carrying unnecessary belongings.",
    "Signal for help using whistles, lights, or emergency devices.",
    "Conserve energy if stranded in the water.",
  ],

  after: [
    "Receive immediate medical attention if injured.",
    "Stay warm to prevent hypothermia.",
    "Report missing passengers to rescue teams.",
    "Cooperate with emergency responders.",
    "Inform family members after reaching safety.",
    "Replace damaged safety equipment.",
    "Document the incident if required.",
    "Follow official investigation procedures.",
    "Seek emotional support if needed.",
    "Review marine safety practices before future travel.",
  ],

  emergencyNumber: "112",
  image: "assets/images/ship1.jpg",
),

   DisasterModel(
    emergencyTip:
"Keep the bitten limb still and seek medical help immediately. Never cut the wound or suck out the venom.",

  id: "24",
  title: "Snake Bite",
  description:
      "A snake bite can be life-threatening if the snake is venomous. Immediate first aid and prompt medical treatment are essential to reduce the effects of venom and improve survival.",

  before: [
    "Wear boots and long pants while walking in forests or fields.",
    "Avoid walking through tall grass without proper footwear.",
    "Use a flashlight when walking outside at night.",
    "Keep your surroundings clean to discourage snakes.",
    "Do not place hands into holes, rocks, or thick bushes.",
    "Educate family members about snake safety.",
    "Know the location of the nearest hospital.",
    "Store emergency numbers on your phone.",
    "Carry a basic first aid kit while hiking.",
    "Stay alert in areas known for snake activity.",
  ],

  during: [
    "Stay calm and avoid panic.",
    "Move away from the snake immediately.",
    "Keep the bitten limb still and below heart level.",
    "Remove rings, watches, or tight clothing before swelling begins.",
    "Do NOT cut the wound or suck out the venom.",
    "Do NOT apply ice, chemicals, or herbal remedies.",
    "Avoid running or excessive movement.",
    "Call emergency medical services immediately.",
    "If safe, remember the snake's appearance without trying to catch it.",
    "Reach the nearest hospital as quickly as possible.",
  ],

  after: [
    "Follow all medical advice completely.",
    "Complete the prescribed treatment.",
    "Watch for signs of infection.",
    "Rest until fully recovered.",
    "Return for follow-up medical checkups if required.",
    "Educate family members about snakebite prevention.",
    "Report venomous snake sightings to local authorities if necessary.",
    "Replace used first aid supplies.",
    "Review outdoor safety practices.",
    "Avoid disturbing snakes in their natural habitat.",
  ],

  emergencyNumber: "108",
  image: "assets/images/snake.png",
),

   DisasterModel(
    emergencyTip:
"Wash bite wounds thoroughly with soap and water for at least 15 minutes and seek medical care immediately.",

  id: "25",
  title: "Animal Attack",
  description:
      "Animal attacks may involve dogs, wild animals, or other aggressive animals. Quick first aid, proper wound care, and immediate medical attention help prevent serious injuries and infections such as rabies.",

  before: [
    "Avoid approaching unknown or wild animals.",
    "Teach children not to disturb animals while eating or sleeping.",
    "Keep pets vaccinated and properly controlled.",
    "Do not provoke or tease animals.",
    "Stay alert while walking in areas with stray animals.",
    "Carry emergency contact numbers.",
    "Avoid feeding wild animals.",
    "Learn basic first aid for bites and scratches.",
    "Keep a first aid kit at home.",
    "Know the nearest medical facility.",
  ],

  during: [
    "Stay calm and avoid sudden movements.",
    "Do not run unless absolutely necessary.",
    "Protect your face, neck, and chest.",
    "Slowly move away if possible.",
    "If bitten, wash the wound immediately with soap and running water for at least 15 minutes.",
    "Apply a clean bandage to control bleeding.",
    "Seek immediate medical attention.",
    "Report aggressive animals to local authorities.",
    "Avoid touching injured wild animals.",
    "Call emergency services if the injury is severe.",
  ],

  after: [
    "Complete the recommended rabies vaccination if prescribed.",
    "Take all antibiotics and medicines as directed.",
    "Monitor the wound for signs of infection.",
    "Keep the wound clean and dry.",
    "Attend follow-up medical appointments.",
    "Document the incident if required.",
    "Inform local authorities about dangerous animals.",
    "Replace used first aid supplies.",
    "Educate family members about animal safety.",
    "Continue observing pets involved in the incident if instructed by veterinarians.",
  ],

  emergencyNumber: "108",
  image: "assets/images/animal.jpg",
),

   DisasterModel(
    emergencyTip:
"Turn off the power source before touching the victim. Never touch them while electricity is still flowing.",

  id: "26",
  title: "Electric Shock",
  description:
      "Electric shock occurs when the human body comes into contact with an electrical current. It can cause severe burns, heart failure, breathing difficulties, and even death. Immediate action can save lives.",

  before: [
    "Never touch damaged electrical wires or exposed cables.",
    "Use electrical appliances according to safety instructions.",
    "Keep electrical devices away from water.",
    "Install proper circuit breakers and safety switches.",
    "Do not overload electrical sockets.",
    "Replace damaged plugs, switches, and extension cords immediately.",
    "Wear insulated gloves and footwear when working with electricity.",
    "Keep children away from electrical outlets.",
    "Know the location of the main power switch.",
    "Store emergency contact numbers for quick access.",
  ],

  during: [
    "Do NOT touch the victim while the power source is active.",
    "Switch off the electricity immediately if possible.",
    "Use a dry wooden stick or other non-conductive object to separate the victim from the power source.",
    "Call emergency medical services immediately.",
    "Check if the victim is breathing and responsive.",
    "Begin CPR only if trained and the victim is not breathing.",
    "Treat burns with clean, cool water but avoid ice.",
    "Do not move the victim unnecessarily if spinal injuries are suspected.",
    "Keep the victim calm until medical help arrives.",
    "Avoid using metal objects near electrical sources.",
  ],

  after: [
    "Seek immediate medical examination even if injuries appear minor.",
    "Follow all prescribed treatments.",
    "Replace damaged electrical equipment.",
    "Repair faulty wiring before restoring power.",
    "Review electrical safety practices at home or work.",
    "Educate family members about electrical safety.",
    "Inspect electrical systems regularly.",
    "Restock first aid supplies.",
    "Document the incident if necessary.",
    "Report damaged public electrical lines to authorities.",
  ],

  emergencyNumber: "108",
  image: "assets/images/electric.jpg",
),

   DisasterModel(
    emergencyTip:
"Protect your head, avoid dust inhalation, and use a whistle or knock on debris to attract rescuers if trapped.",

  id: "27",
  title: "Building Collapse",
  description:
      "A building collapse can occur due to earthquakes, explosions, structural failure, floods, or fires. Quick evacuation and proper emergency response are essential for survival.",

  before: [
    "Know all emergency exits in your building.",
    "Report visible cracks or structural damage immediately.",
    "Participate in evacuation drills.",
    "Keep emergency kits easily accessible.",
    "Avoid overloading balconies and rooftops.",
    "Store emergency contact numbers.",
    "Learn basic first aid.",
    "Identify safe open areas nearby.",
    "Keep important documents ready for emergencies.",
    "Follow building safety regulations.",
  ],

  during: [
    "Stay calm and avoid panic.",
    "Protect your head and neck with your arms or sturdy furniture.",
    "Do not use elevators.",
    "Move toward the nearest safe exit if possible.",
    "Avoid windows, glass, and falling debris.",
    "If trapped, cover your mouth with cloth to reduce dust inhalation.",
    "Use a whistle or knock on objects to attract rescuers.",
    "Conserve your energy while waiting for rescue.",
    "Help injured people only if it is safe.",
    "Call emergency services immediately.",
  ],

  after: [
    "Stay away from damaged buildings.",
    "Watch for gas leaks and exposed electrical wires.",
    "Receive medical attention for injuries.",
    "Follow rescue team instructions.",
    "Report missing persons immediately.",
    "Avoid entering unstable structures.",
    "Document property damage.",
    "Support affected family members emotionally.",
    "Restock emergency supplies.",
    "Review building safety procedures.",
  ],

  emergencyNumber: "112",
  image: "assets/images/building2.jpeg",
),

  DisasterModel(
    emergencyTip:
"Do not switch electrical devices on or off. Open windows, close the gas valve, and evacuate immediately.",
  id: "28",
  title: "Gas Leak",
  description:
      "A gas leak occurs when natural gas or LPG escapes from pipelines or cylinders. Gas leaks can lead to fires, explosions, poisoning, and suffocation if not handled safely.",

  before: [
    "Inspect gas cylinders, pipes, and regulators regularly.",
    "Install gas leak detectors where possible.",
    "Ensure kitchens and gas storage areas are well ventilated.",
    "Learn how to turn off the gas supply.",
    "Keep emergency contact numbers available.",
    "Never use damaged gas equipment.",
    "Replace old gas pipes and regulators on time.",
    "Keep fire extinguishers nearby.",
    "Store LPG cylinders in an upright position.",
    "Educate family members about gas safety.",
  ],

  during: [
    "Do NOT switch electrical appliances or lights on or off.",
    "Do NOT use mobile phones near the leak.",
    "Immediately close the gas valve if safe.",
    "Open all doors and windows for ventilation.",
    "Evacuate everyone from the building.",
    "Avoid lighting matches or creating sparks.",
    "Call the gas supplier or emergency services from a safe location.",
    "Keep children and elderly people away from the area.",
    "Stay away until professionals declare it safe.",
    "Warn nearby people about the leak.",
  ],

  after: [
    "Allow qualified technicians to inspect the gas system.",
    "Do not restore gas supply until repairs are complete.",
    "Replace damaged cylinders, pipes, or regulators.",
    "Inspect your home for fire or explosion damage.",
    "Seek medical attention if anyone inhaled gas.",
    "Review gas safety procedures with your family.",
    "Replace emergency supplies if used.",
    "Install additional gas safety devices if needed.",
    "Document damages if required.",
    "Continue monitoring for unusual gas smells.",
  ],

  emergencyNumber: "1906",
  image: "assets/images/gas1.jpg",
),
  ];
}