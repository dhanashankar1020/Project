import 'dart:math';
import '../models/user_intent.dart';
import '../../safe_places/models/safe_place_model.dart';
import '../../safe_places/services/safe_places_service.dart';

/// Offline AI response model
class AIResponseData {
  final String text;
  final List<SafePlaceModel>? recommendedPlaces;
  
  const AIResponseData({required this.text, this.recommendedPlaces});
}

/// Service that generates contextually relevant responses entirely offline.
/// Uses the detected [UserIntent] to select appropriate pre-written guides,
/// instructions, and safety information.
class OfflineAIService {
  OfflineAIService._();
  static final OfflineAIService instance = OfflineAIService._();

  final Random _random = Random();

  /// Generates a contextual offline response based on the [query] and [intent].
  AIResponseData generateResponse(String query, UserIntent intent) {
    if (intent.isSafePlace) {
      return _getSafePlaceResponse(intent.safePlaceType);
    }
    if (intent.isFirstAid) {
      return _getFirstAidResponse(intent.firstAidType);
    }
    if (intent.isEmergency) {
      return _getEmergencyResponse(intent.emergencyType);
    }
    if (intent.isGeneralChat) {
      return _getGeneralChatResponse(query);
    }
    return _getFallbackResponse();
  }

  AIResponseData _getSafePlaceResponse(SafePlaceType type) {
    final service = SafePlacesService.instance;

    switch (type) {
      case SafePlaceType.hospital:
        return AIResponseData(
          text: '''🏥 **Nearby Hospitals & Medical Centers**

I can help you find medical facilities nearby.

**Key Information:**
• Go to the nearest hospital for medical emergencies
• Call ahead if possible to check bed availability
• Emergency rooms (ER) are open 24/7
• Have your ID and insurance information ready

**Quick Actions:**
1. Use "Safe Places" feature to find hospitals
2. Tap "Navigate" to get Google Maps directions
3. Call emergency services if needed

📍 **Tip:** Save your preferred hospital in the Safe Places section for quick access during emergencies.''',
          recommendedPlaces: service.getPlacesByCategory('Hospital'),
        );

      case SafePlaceType.shelter:
        return AIResponseData(
          text: '''🏠 **Emergency Shelters & Evacuation Centers**

Finding safe shelter is a priority during disasters.

**Nearby Shelter Options:**
• Storm shelters
• Government evacuation centers
• Red Cross relief camps
• Community centers (often used as shelters)
• Schools and churches (may be designated shelters)

**What to Bring to a Shelter:**
• Water and non-perishable food (3-day supply)
• Medications and first aid kit
• Important documents (ID, insurance, medical records)
• Warm clothing and blankets
• Flashlight and batteries
• Phone charger and power bank

📍 **Tip:** Find the nearest shelter in the Safe Places section of this app!''',
          recommendedPlaces: service.getPlacesByCategory('Shelter'),
        );

      case SafePlaceType.policeStation:
        return AIResponseData(
          text: '''👮 **Police Stations**

Police stations provide security and assistance during emergencies.

**Services Available:**
• Emergency response and protection
• Crime reporting and assistance
• Lost and found
• Guidance during disasters
• Security escorts if needed

**Emergency Contacts:**
• Police Emergency: 100
• National Emergency: 112

📍 **Note:** You can find the nearest police station in the Safe Places section.''',
          recommendedPlaces: service.getPlacesByCategory('Police Station'),
        );

      case SafePlaceType.fireStation:
        return AIResponseData(
          text: '''🚒 **Fire Stations**

Fire stations are equipped to handle various emergencies beyond fires.

**Services Provided:**
• Fire suppression and rescue
• Medical emergency response
• Hazardous materials incidents
• Vehicle extrication
• Search and rescue operations

**Emergency Numbers:**
• Fire Emergency: 101
• National Emergency: 112

🔥 **Safety Tip:** Know two ways out of every room and practice your family fire drill!''',
          recommendedPlaces: service.getPlacesByCategory('Fire Station'),
        );

      case SafePlaceType.pharmacy:
        return AIResponseData(
          text: '''💊 **Pharmacies & Medicine Stores**

Access to medication is critical during emergencies.

**What Pharmacies Offer:**
• Prescription medications
• Over-the-counter medicines
• First aid supplies
• Emergency contraception
• Vaccinations (some locations)

**Quick Tips:**
• Keep a 30-day supply of essential medications
• Store medications in a waterproof container
• Check expiry dates regularly
• Note the pharmacy's operating hours

📍 **Find nearby pharmacies** in the Safe Places section!''',
          recommendedPlaces: service.getPlacesByCategory('Pharmacy'),
        );

      case SafePlaceType.reliefCamp:
        return AIResponseData(
          text: '''⛑️ **Relief Camps**

Relief camps provide temporary shelter and essential supplies after disasters.

**What's Typically Available:**
• Emergency shelter and bedding
• Food and drinking water
• Medical assistance
• Basic sanitation facilities
• Information and support services

**When to Go to a Relief Camp:**
• Your home is damaged or unsafe
• Authorities announce evacuation
• You lack basic necessities
• You need medical attention

📍 **Check Safe Places** for nearby relief camps and evacuation centers.''',
          recommendedPlaces: service.getPlacesByCategory('Relief Center'),
        );

      case SafePlaceType.unknown:
        return AIResponseData(
          text: '''📍 **Safe Places Nearby**

I can help you find safe locations in your area.

**Types of Safe Places Available:**
• 🏥 Hospitals & Clinics
• 🚒 Fire Stations
• 👮 Police Stations
• 🏠 Emergency Shelters
• 💊 Pharmacies
• ⛑️ Relief Camps

**How to Use:**
1. Open the **Safe Places** section from the home screen
2. Use the **search bar** to filter by name or type
3. Tap any location to **get directions** via Google Maps
4. Use the **offline/online toggle** to switch data sources

🔄 **Offline Mode:** Safe places are still accessible without internet!''',
          recommendedPlaces: service.getAllPlaces(),
        );
    }
  }

  AIResponseData _getFirstAidResponse(FirstAidType type) {
    switch (type) {
      case FirstAidType.cardiacCPR:
        return const AIResponseData(
          text: '''❤️ **Offline First Aid Guide: CPR (Cardiopulmonary Resuscitation)**

**BEFORE – Check for Responsiveness:**
1. Tap the person's shoulder and shout loudly
2. Check if they are breathing normally (look, listen, feel for 10 seconds)
3. Call emergency services immediately (112 or 108)

**DURING – Perform CPR (CAB Sequence):**

**C – Compressions (30 chest compressions):**
• Place the heel of one hand on the center of the chest
• Place your other hand on top, interlocking fingers
• Keep your arms straight and shoulders directly over your hands
• Push hard and fast: at least 2 inches deep, 100-120 compressions per minute
• Allow the chest to fully recoil between compressions

**A – Airway:**
• Tilt the head back by lifting the chin
• Check for any visible obstructions in the mouth

**B – Breathing (2 rescue breaths):**
• Pinch the nose shut
• Make a complete seal over the person's mouth with yours
• Give 2 breaths, each 1 second long
• Watch for the chest to rise

**AFTER – Continue Until:**
• Emergency services arrive and take over
• The person shows signs of life
• You are too exhausted to continue

⚠️ **Remember:** Hands-only CPR (compressions without breaths) is still effective if you're untrained or unwilling to give breaths. Continue at 100-120 compressions per minute to the beat of "Stayin' Alive" by the Bee Gees!''',
        );

      case FirstAidType.burn:
        return const AIResponseData(
          text: '''🔥 **Offline First Aid Guide: Burn Treatment**

**BEFORE – Assess the Burn:**
• **First-degree:** Red, painful, no blisters (sunburn-like)
• **Second-degree:** Red, blistered, swollen, very painful
• **Third-degree:** White, charred, leathery, little to no pain (nerve damage)

**DURING – Immediate Treatment:**

**For Minor Burns (First-degree & small second-degree):**
1. **COOL** – Run cool (not cold) water over the burn for 10-20 minutes
2. **COVER** – Apply a sterile gauze bandage loosely
3. **PAIN** – Take over-the-counter pain relievers if available
4. **MOISTURIZE** – Apply aloe vera or burn cream

**For Severe Burns (Large second-degree & third-degree):**
1. **CALL** emergency services immediately (112)
2. **DON'T** remove burned clothing stuck to the skin
3. **DON'T** apply ice or cold water to large burns
4. **DON'T** apply ointments or butter (home remedies)
5. **COVER** with a clean, dry cloth or sterile dressing

**AFTER – Follow-up Care:**
• Watch for signs of infection (increased pain, redness, pus)
• Keep the burn clean and protected
• Don't pop blisters – they protect against infection
• Seek medical attention for burns on face, hands, feet, or genitals

⚠️ **Important:** For electrical burns, chemical burns, or burns with difficulty breathing, seek emergency help immediately!''',
        );

      case FirstAidType.bleeding:
        return const AIResponseData(
          text: '''🩸 **Offline First Aid Guide: Bleeding & Wound Care**

**BEFORE – Prepare:**
• Put on gloves if available (protect yourself from bloodborne pathogens)
• Clean your hands if possible
• Have clean cloth or gauze ready

**DURING – Control Bleeding:**

**For Minor Bleeding:**
1. Clean the wound with clean water (not alcohol or hydrogen peroxide)
2. Apply gentle pressure with a clean cloth
3. Cover with a sterile bandage or adhesive bandage
4. Keep the wound clean and dry

**For Severe Bleeding:**
1. **CALL** emergency services (112) immediately
2. **PRESS** – Apply direct, firm pressure with a clean cloth or gauze
3. **ELEVATE** – Raise the injured area above heart level (if no fracture)
4. **DO NOT** remove the cloth if it becomes soaked – add another on top
5. **PRESSURE POINTS** – If bleeding doesn't stop, apply pressure to the main artery
6. **TOURNIQUET** – Only use as a LAST RESORT for life-threatening limb bleeding

**AFTER – Once Bleeding is Controlled:**
• Clean around the wound gently
• Apply antibiotic ointment if available
• Cover with sterile dressing
• Change bandages daily
• Watch for signs of infection

⚠️ **Seek Medical Help If:**
• Bleeding doesn't stop after 15 minutes of pressure
• The wound is deep, large, or has embedded objects
• You can't clean the wound properly
• Signs of infection develop (redness, swelling, warmth, pus)''',
        );

      case FirstAidType.fracture:
        return const AIResponseData(
          text: '''🦴 **Offline First Aid Guide: Fractures & Sprains**

**BEFORE – Identify the Injury:**
• **Closed Fracture:** Bone broken, skin intact
• **Open Fracture:** Bone piercing through the skin
• **Sprain:** Ligament injury (swelling, bruising, pain with movement)
• **Strain:** Muscle or tendon injury

**DURING – Immobilization:**

**For Fractures:**
1. **DO NOT** move or straighten the injured area
2. **IMMOBILIZE** using a splint (board, rolled magazine, or sturdy object)
3. **PAD** the splint with soft material
4. **TIE** the splint above and below the injury (not directly over it)
5. **ICE** the area to reduce swelling (never apply ice directly to skin)
6. **ELEVATE** if possible

**For Sprains (R.I.C.E. Method):**
• **R**est – Stop using the injured area
• **I**ce – Apply ice packs for 20 minutes at a time
• **C**ompression – Wrap with an elastic bandage
• **E**levation – Keep raised above heart level

**AFTER – Follow-up:**
• Seek medical attention for proper diagnosis
• Don't bear weight on a suspected fracture
• Watch for numbness, tingling, or loss of circulation below the injury

⚠️ **DO NOT:**
• Attempt to push bones back in
• Move the person if spine injury is suspected
• Apply heat to a fresh injury (use ice)''',
        );

      case FirstAidType.choking:
        return const AIResponseData(
          text: '''🫁 **Offline First Aid Guide: Choking**

**BEFORE – Recognize Signs:**
• Cannot cough, speak, or breathe
• Clutching the throat (universal choking sign)
• Face turns blue or red
• Panicked appearance

**DURING – Perform Heimlich Maneuver:**

**For Adults & Children (over 1 year):**
1. Stand behind the person and wrap your arms around their waist
2. Make a fist with one hand, thumb side against the person's abdomen
3. Place your fist just above the navel (belly button)
4. Grasp your fist with the other hand
5. Give 5 quick, inward and upward thrusts
6. Alternate with 5 back blows between the shoulder blades
7. Repeat until the object is dislodged or the person becomes unconscious

**For Infants (under 1 year):**
1. Hold the infant face-down on your forearm, head lower than chest
2. Give 5 firm back blows between the shoulder blades
3. Turn the infant face-up on your forearm
4. Give 5 chest thrusts using 2 fingers (in the center of the chest)
5. Repeat until the object is dislodged

**For Yourself (if alone):**
1. Make a fist and place it above your navel
2. Grasp your fist and thrust inward and upward
3. OR lean over a firm object (chair back, table edge, counter) and press your abdomen against it

**AFTER – The Object is Dislodged:**
• Seek medical attention – the person may have internal injuries
• The object may have damaged the airway
• Watch for difficulty breathing or swallowing

⚠️ **If the person becomes unconscious:** Call emergency services (112) and begin CPR, checking the mouth for the object each time you open the airway.''',
        );

      default:
        return const AIResponseData(
          text: '''🩹 **First Aid Information**

For specific first aid instructions, please ask about:
• CPR (cardiac emergency)
• Burns
• Bleeding and wounds
• Fractures and sprains
• Choking
• Poisoning
• Drowning
• Allergic reactions (shock)

⚠️ **Emergency:** If the situation is life-threatening, call 112 or your local emergency number immediately!''',
        );
    }
  }

  AIResponseData _getEmergencyResponse(EmergencyType type) {
    switch (type) {
      case EmergencyType.earthquake:
        return const AIResponseData(
          text: '''🌍 **Offline Disaster Guide: Earthquake**

**BEFORE an Earthquake:**
• Secure heavy furniture to walls (bookshelves, cabinets, water heaters)
• Store breakable items in low, closed cabinets
• Know how to turn off gas, water, and electricity
• Prepare an emergency kit with water, food, flashlight, and first aid supplies
• Identify safe spots in each room (under sturdy tables, against interior walls)
• Practice "Drop, Cover, and Hold On" drills with your family

**DURING an Earthquake:**

**If Indoors:**
• **DROP** – Drop down to your hands and knees
• **COVER** – Cover your head and neck under a sturdy table or desk
• **HOLD ON** – Hold on until the shaking stops
• Stay away from windows, glass, and exterior walls
• Don't use elevators

**If Outdoors:**
• Move away from buildings, streetlights, and utility wires
• Find an open area and stay there until shaking stops

**If Driving:**
• Pull over to a safe spot away from overpasses and buildings
• Stay in your vehicle until shaking stops

**AFTER an Earthquake:**
• Expect aftershocks – they can be strong
• Check yourself and others for injuries
• Put on shoes to protect from broken glass
• Check for gas leaks, structural damage, and fire hazards
• Listen to emergency broadcasts for instructions
• Avoid using phones except for emergencies (keep lines open)
• Open cabinets carefully – items may have shifted
• Be prepared for tsunami risk if near the coast

📱 **Stay safe!** Use the Safe Places feature to find shelters and medical help.''',
        );

      case EmergencyType.flood:
        return const AIResponseData(
          text: '''🌊 **Offline Disaster Guide: Flood**

**BEFORE a Flood:**
• Know your area's flood risk and evacuation routes
• Elevate critical utilities (electrical panel, water heater, furnace)
• Install sump pumps and check drainage
• Prepare sandbags if needed
• Keep emergency supplies in a waterproof container
• Store important documents in waterproof bags
• Charge all devices and power banks

**DURING a Flood:**

**If Indoors:**
• Move to the highest floor or roof (but NOT an enclosed attic)
• Turn off utilities at the main switches (if instructed)
• Never use electrical equipment in standing water
• Fill bathtubs and containers with clean water

**If Outdoors:**
• Move to high ground immediately
• NEVER walk, swim, or drive through floodwater
• Just 6 inches of fast-moving water can knock you over
• Just 12 inches can carry away a car

**If Driving:**
• Turn around – don't drown! Never drive through flooded roads
• If your car stalls in rising water, abandon it and move to higher ground

**AFTER a Flood:**
• Wait for authorities to say it's safe to return
• Watch for hidden dangers (sharp debris, snakes, electrical hazards)
• Don't use contaminated water for drinking, cooking, or bathing
• Document damage with photos for insurance
• Clean and disinfect everything that got wet
• Be aware of mold growth – dry out your home within 24-48 hours

⚠️ **Health Warning:** Floodwater may contain sewage, chemicals, and wildlife. Avoid direct contact!''',
        );

      default:
        return const AIResponseData(
          text: '''⚠️ **Emergency Preparedness Guide**

**General Emergency Steps:**
1. **STAY CALM** – Panic leads to poor decisions
2. **ASSESS** the situation and identify immediate dangers
3. **CALL** emergency services (112) if needed
4. **EVACUATE** if the area is unsafe
5. **HELP** others who may need assistance (if safe to do so)

**Essential Emergency Kit:**
• Water (1 gallon per person per day for 3 days)
• Non-perishable food (3-day supply)
• First aid kit and medications
• Flashlight and batteries
• Battery-powered or hand-crank radio
• Multi-tool and whistle
• Important documents (copies)
• Cell phone with chargers/power bank
• Cash and emergency contact list
• Warm clothing and blankets

📍 **Use this app's Safe Places feature to find nearby shelters, hospitals, and emergency services!**''',
        );
    }
  }

  AIResponseData _getGeneralChatResponse(String query) {
    final lowerQuery = query.toLowerCase();

    if (lowerQuery.contains('hello') || lowerQuery.contains('hi ') || lowerQuery == 'hi') {
      return const AIResponseData(
        text: '''👋 **Hello! I'm your Offline Disaster Assistant.**

I can help you with:
• 🏥 Finding **safe places** (hospitals, shelters, etc.)
• 🩹 **First aid** instructions (CPR, burns, bleeding, etc.)
• 🌪️ **Disaster guides** (earthquake, flood, fire, etc.)
• 📞 **Emergency contacts** and numbers

**How can I help you today?** Just ask me anything about staying safe!

💡 *Tip: All features work offline, so you're always prepared!*''',
      );
    }

    if (lowerQuery.contains('thank') || lowerQuery.contains('thanks')) {
      return const AIResponseData(
        text: '''🙏 **You're welcome!** Stay safe out there.

Remember, I'm always here to help – even without internet access.

**Quick Tips:**
• Explore the **Safe Places** feature from the home screen
• Check **First Aid** for medical instructions
• Review **Disaster Guides** for various emergencies
• Save **Emergency Contacts** for quick access

🛟 *Don't hesitate to ask if you need anything else!*''',
      );
    }

    if (lowerQuery.contains('how are you') || lowerQuery.contains('how do you work')) {
      return const AIResponseData(
        text: '''🤖 **I'm functioning perfectly!** Here's how I work:

• I'm a fully **offline AI assistant** – no internet needed!
• I use **keyword matching** to understand your questions
• I provide **pre-written emergency guides** tailored to your needs
• I can help you find **safe places** and navigate to them
• I work **100% offline** – your data never leaves your device

**Try asking me about:**
• "Where is the nearest hospital?"
• "How to perform CPR?"
• "What should I do during an earthquake?"
• "Find me a shelter"

💪 *I'm here to keep you safe, anytime, anywhere!*''',
      );
    }

    // Default general response
    return const AIResponseData(
      text: '''🤔 **I understand you need help.**

I can provide information on these topics:

**🏥 Safe Places:** Ask about hospitals, shelters, police stations, fire stations, or pharmacies near you.

**🩹 First Aid:** Ask about CPR, burns, bleeding, fractures, choking, poisoning, and more.

**🌪️ Emergency Guides:** Ask about earthquakes, floods, hurricanes, tornadoes, wildfires, and other disasters.

**📞 Emergency Contacts:** Use the Emergency Contacts feature on the home screen.

💡 **Try being more specific**, like "What should I do during a flood?" or "Find me a shelter nearby."''',
    );
  }

  AIResponseData _getFallbackResponse() {
    return const AIResponseData(
      text: '''📋 **I'm here to help with emergency and safety information.**

I can assist you with:
• Finding **safe places** (hospitals, shelters, police stations, etc.)
• **First aid instructions** for various medical emergencies
• **Disaster preparedness** guides
• **Emergency contacts** and important numbers

**Try asking:**
• "Where is the nearest hospital?"
• "How to perform CPR?"
• "What should I do during an earthquake?"
• "Find me a storm shelter"

🛟 *Stay safe! All features work offline.*''',
    );
  }
}
