class ExerciseCategory {
  String name;
  String duration;
  String cal;
  List<Exercise> exercises;

  ExerciseCategory(
      {required this.name,
      required this.duration,
      required this.cal,
      required this.exercises});
}

class Exercise {
  String title;
  String subtitle;
  String thumbUrl;
  String imageUrl;
  String videoUrl;

  Exercise(
      {required this.title,
      required this.subtitle,
      required this.thumbUrl,
      required this.imageUrl,
      required this.videoUrl});
}

List<ExerciseCategory> categories = [
  ExerciseCategory(
    name: 'Abs',
    duration: '20:00',
    cal: '153',
    exercises: [
      Exercise(
        title: 'Jumping Jacks',
        subtitle:
            'Stand up straight with your feet together and your arms at your sides. Jump up and spread your feet apart while raising your arms above your head. Land on the balls of your feet and keep your knees slightly bent. Jump again and bring your feet back together while lowering your arms to your sides. Repeat the exercise for the desired number of repetitions',
        thumbUrl: 'assets/wk/thumbs/33.gif',
        imageUrl: 'assets/wk/33.gif',
        videoUrl: 'https://www.youtube.com/watch?v=2W4ZNSwoW_4',
      ),
      Exercise(
        title: 'High Stepping',
        subtitle:
            'High Stepping is a cardio exercise that involves lifting your knees as high as you can while stepping in place. Swing your arms naturally and maintain a quick pace. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/13.gif',
        imageUrl: 'assets/wk/13.gif',
        videoUrl: 'https://youtu.be/Cmxr9xcNhgU',
      ),
      Exercise(
        title: 'Standing Bicycle Crunch',
        subtitle:
            'Standing Bicycle Crunch is a core exercise that involves twisting your torso while bringing your elbow to the opposite knee. Keep your back straight and perform the exercise at a quick pace. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/37.gif',
        imageUrl: 'assets/wk/37.gif',
        videoUrl: 'https://www.youtube.com/watch?v=8lsAXzvVHrc',
      ),

      Exercise(
        title: 'Russian Twist',
        subtitle:
            'Russian Twist is a core exercise that involves twisting your torso from side to side while balancing on your glutes. Keep your back straight and perform the exercise at a quick pace. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/46.gif',
        imageUrl: 'assets/wk/46.gif',
        videoUrl: 'https://www.youtube.com/watch?v=DJQGX2J4IVw',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=snSqy2pPEa4',
        title: 'Mountain Climber',
        subtitle:
            'Mountain Climber is a full-body exercise that involves getting into a plank position and bringing your knees to your chest, alternating legs. Keep your core engaged and perform the exercise at a quick pace. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/59.gif',
        imageUrl: 'assets/wk/59.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=9i0J_I4ASow',
        title: 'Flutter Kicks',
        subtitle:
            'Flutter Kicks is a lower abs exercise that involves lying on your back with your legs straight and lifting them a few inches off the ground. Then, alternate kicking your legs up and down in a fluttering motion, while keeping your core engaged and your back flat on the ground. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/24.gif',
        imageUrl: 'assets/wk/24.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=by8bvR0r178',
        title: 'Leg Raises',
        subtitle:
            'Leg Raises is a lower abs exercise that involves lying on your back with your legs straight and lifting them up to a 90-degree angle, then lowering them back down to the ground. Keep your core engaged and your back flat on the ground throughout the movement. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/73.gif',
        imageUrl: 'assets/wk/73.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=6gGzYaD9Cb4',
        title: 'Butt Bridge',
        subtitle:
            'Butt Bridge is a glutes exercise that involves lying on your back with your knees bent and your feet flat on the ground, then lifting your hips up toward the ceiling. Squeeze your glutes at the top of the movement and lower your hips back down to the ground. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/10.gif',
        imageUrl: 'assets/wk/10.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=CYGeazlNbU4',
        title: 'Skipping Without Rope',
        subtitle:
            'Skipping Without Rope is a cardiovascular exercise that mimics the motion of jumping rope without an actual rope. Jump up and down on the balls of your feet, keeping your knees slightly bent and your arms at your sides. Keep a steady pace and repeat for the desired amount of time.',
        thumbUrl: 'assets/wk/thumbs/74.gif',
        imageUrl: 'assets/wk/74.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=9A7ZAXxMV0Q',
        title: 'Plank',
        subtitle:
            'Plank is a full-body exercise that involves holding a straight line from your head to your heels while balancing on your forearms and toes. Keep your core engaged and your back flat throughout the exercise. Hold the position for the desired amount of time.',
        thumbUrl: 'assets/wk/wkimgs/106.png',
        imageUrl: 'assets/wk/wkimgs/106.png',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=z21McHHOpAg',
        title: 'Cobra Stretch',
        subtitle:
            'Cobra Stretch is a back stretch exercise that involves lying on your stomach with your hands on the ground under your shoulders. Push your chest up and arch your back, keeping your elbows close to your sides. Hold the position for the desired amount of time.',
        thumbUrl: 'assets/wk/wkimgs/86.png',
        imageUrl: 'assets/wk/wkimgs/86.png',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=ZI-j_POtzlU',
        title: 'Lying Twist Stretch Left',
        subtitle:
            'Lying Twist Stretch (Left) is a back stretch exercise that involves lying on your back with your arms stretched out to the sides. Bend your left knee and bring it across your body toward the ground on the right side, keeping your right leg straight. Hold the position for the desired amount of time.',
        thumbUrl: 'assets/wk/wkimgs/96.png',
        imageUrl: 'assets/wk/wkimgs/96.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=ZI-j_POtzlU',
        title: 'Lying Twist Stretch Right',
        subtitle:
            'Lying Twist Stretch (Right) is a back stretch exercise that involves lying on your back with your arms stretched out to the sides. Bend your right knee and bring it across your body toward the ground on the left side, keeping your left leg straight. Hold the position for the desired amount of time.',
        thumbUrl: 'assets/wk/wkimgs/97.png',
        imageUrl: 'assets/wk/wkimgs/97.png',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=dV8ll1vnle0',
        title: 'Reverse Crunches',
        subtitle:
            'Reverse Crunches is a lower abs exercise that involves lying on your back with your legs bent and your feet flat on the ground. Lift your hips off the ground and bring your knees toward your chest, then lower them back down to the starting position. Keep your core engaged and your back flat on the ground throughout the exercise. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/3.gif',
        imageUrl: 'assets/wk/3.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=9bR-elyolBQ',
        title: 'Heel Touch',
        subtitle:
            'For Heel Touch Lie On The Ground with your legs bent and your arrms by your side slightly lift your upper body off the floor',
        thumbUrl: 'assets/wk/thumbs/52.gif',
        imageUrl: 'assets/wk/52.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=XKW5jru5pGo',
        title: 'Reclined Oblique Twist',
        subtitle:
            'Reclined Oblique Twist is a core exercise that involves lying on your back with your knees bent and feet flat on the ground. Keeping your shoulders on the ground, twist your lower body to the left side and then to the right side, touching your knees to the ground on each side. Keep your core engaged and your back flat on the ground throughout the exercise. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/75.gif',
        imageUrl: 'assets/wk/75.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=wdS2U6z0JGY',
        title: 'Heels to Heaven',
        subtitle:
            'Heels to Heaven is a lower abs exercise that involves lying on your back with your legs extended straight up towards the ceiling. Keeping your lower back on the ground, lift your hips off the ground and bring your legs towards your chest, then slowly lower them back down to the starting position. Keep your core engaged throughout the exercise. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/wkimgs/s1.gif',
        imageUrl: 'assets/wk/wkimgs/s1.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=8fN356WKqPo',
        title: 'Cross Knee Plank',
        subtitle:
            'Cross Knee Plank is a core exercise that involves starting in a plank position, with your forearms and toes on the ground, and your body in a straight line. Bring your left knee across your body and touch it to your right elbow, then return to the starting position and repeat on the other side. Keep your core engaged and your back flat throughout the exercise. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/59.gif',
        imageUrl: 'assets/wk/59.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Qz3ylqqJ90M',
        title: 'Cross Arm Crunch',
        subtitle:
            'Cross Arm Crunch is a core exercise that involves lying on your back with your knees bent and feet flat on the ground. Cross your arms over your chest or place your hands behind your head, then lift your shoulders off the ground and bring your right elbow towards your left knee. Return to the starting position and repeat on the other side. Keep your core engaged and your back flat on the ground throughout the exercise. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/47.gif',
        imageUrl: 'assets/wk/47.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=f_ZsJgaqFNE',
        title: 'X Man Crunch',
        subtitle:
            'Lie On your back with your hands stretched at your sides and legs apart.',
        thumbUrl: 'assets/wk/thumbs/5.gif',
        imageUrl: 'assets/wk/5.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=w0OWFjfI3zM',
        title: 'Side Crunches Right',
        subtitle:
            'Side Crunches are a core exercise that involve lying on your side with your legs bent and your bottom arm extended straight out. Place your top hand behind your head, then lift your shoulders off the ground and bring your elbow towards your hip. Keep your core engaged and your back straight throughout the exercise. Repeat for the desired number of repetitions on your right side, then switch to your left side.',
        thumbUrl: 'assets/wk/thumbs/71.gif',
        imageUrl: 'assets/wk/71.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=w0OWFjfI3zM',
        title: 'Side Crunches Left',
        subtitle:
            'Lying on your side, place your bottom arm straight out and your top hand behind your head. Lift your shoulders off the ground and bring your elbow towards your hip. Keep your core engaged and your back straight. Repeat for the desired number of repetitions on your left side, then switch to your right side.',
        thumbUrl: 'assets/wk/thumbs/72.gif',
        imageUrl: 'assets/wk/72.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Xsi17eYdNN0',
        title: 'V Hold',
        subtitle:
            'The V Hold is a core exercise that involves sitting on the floor with your legs straight out in front of you. Lean back slightly and lift your legs off the ground, keeping them straight. Reach your arms straight out in front of you to form a "V" shape with your body. Hold the position for the desired amount of time, then release. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/wkimgs/110.png',
        imageUrl: 'assets/wk/wkimgs/110.png',
      ),
      // add more exercises here
    ],
  ),
  ExerciseCategory(
    name: 'Arms',
    duration: '22:00',
    cal: '132',
    exercises: [
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=kLmWN3Qsj0A',
        title: 'Dynamic Chest',
        subtitle:
            'Dynamic Chest is a type of arm and chest exercise that involves holding your hands close together on a straight line, then opening them up to your sides. The exercise targets your chest, arms, and shoulders. Repeat for the desired number of repetitions, keeping your core engaged and your back straight throughout the exercise.',
        thumbUrl: 'assets/wk/thumbs/52.gif',
        imageUrl: 'assets/wk/52.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=reeBHtZJ1ts',
        title: 'Punches',
        subtitle:
            'Punches are an arm exercise that involve standing with your feet shoulder-width apart and punching forward with your arms. Keep your core engaged and your fists tight throughout the exercise, and alternate punching with each arm. Repeat for the desired number of repetitions, or incorporate punches into a full-body workout routine.',
        thumbUrl: 'assets/wk/thumbs/54.gif',
        imageUrl: 'assets/wk/54.gif',
      ),
      Exercise(
        title: 'Jumping Jacks',
        subtitle:
            'Stand up straight with your feet together and your arms at your sides. Jump up and spread your feet apart while raising your arms above your head. Land on the balls of your feet and keep your knees slightly bent. Jump again and bring your feet back together while lowering your arms to your sides. Repeat the exercise for the desired number of repetitions',
        thumbUrl: 'assets/wk/thumbs/33.gif',
        imageUrl: 'assets/wk/33.gif',
        videoUrl: 'https://www.youtube.com/watch?v=2W4ZNSwoW_4',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=geNkbcZ6qDo',
        title: 'Triseps Dips',
        subtitle:
            'Triceps Dips are an arm exercise that involve placing your hands on a bench or other elevated surface behind you, with your fingers pointing forward. Walk your feet out until your knees are at a 90-degree angle, then lower yourself down by bending your elbows. ',
        thumbUrl: 'assets/wk/thumbs/50.gif',
        imageUrl: 'assets/wk/50.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=P7lSsHQZqBc',
        title: 'Wall Push Ups',
        subtitle:
            'Wall Push-Ups are an arm and chest exercise that involve standing in front of a wall with your feet hip-width apart and your hands flat against the wall. Slowly lower your body towards the wall by bending your elbows, then push yourself back up to the starting position. ',
        thumbUrl: 'assets/wk/thumbs/51.gif',
        imageUrl: 'assets/wk/51.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Lha66p0ZXUc',
        title: 'Arm Circle Clock Wise',
        subtitle:
            'Arm Circles Clockwise are an arm exercise that involve standing with your feet shoulder-width apart and your arms extended out to the sides. Move your arms in a circular motion, starting with small circles and gradually increasing the size of the circles.',
        thumbUrl: 'assets/wk/thumbs/52.gif',
        imageUrl: 'assets/wk/52.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Lha66p0ZXUc',
        title: 'Arm Circles Counterclockwise',
        subtitle:
            'Arm Circles Counterclockwise are an arm exercise that involve standing with your feet shoulder-width apart and your arms extended out to the sides. Move your arms in a circular motion, starting with small circles and gradually increasing the size of the circles',
        thumbUrl: 'assets/wk/thumbs/52.gif',
        imageUrl: 'assets/wk/52.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=KFxW5amBbsw',
        title: 'Knee Push Ups',
        subtitle:
            'Knee Push-Ups are a modified version of the traditional push-up that involve getting down on your hands and knees and extending your legs behind you, with your toes touching the ground',
        thumbUrl: 'assets/wk/thumbs/55.gif',
        imageUrl: 'assets/wk/55.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=wiyvVpEKOsc',
        title: 'Alternating Hooks',
        subtitle:
            'Alternating Hooks are a boxing exercise that involve standing with your feet shoulder-width apart and your fists in front of you. Punch with your left fist towards your right side,',
        thumbUrl: 'assets/wk/thumbs/54.gif',
        imageUrl: 'assets/wk/54.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Rr1Xq5Hmg7A',
        title: 'Up and Down Planks',
        subtitle:
            'Up and Down Planks are a core exercise that involve starting in a high plank position with your arms extended and your core engaged. Lower yourself down to your forearms one arm at a time, then back up to a high plank one arm at a time.',
        thumbUrl: 'assets/wk/thumbs/55.gif',
        imageUrl: 'assets/wk/55.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Fz4oo1vFo9M',
        title: 'Chest Press Pulse',
        subtitle:
            'Chest Press Pulse is a chest exercise that involves lying flat on your back with your knees bent and your feet on the ground. Hold dumbbells or a barbell in each hand, with your arms bent at a 90-degree angle and your hands facing towards your feet.',
        thumbUrl: 'assets/wk/thumbs/57.gif',
        imageUrl: 'assets/wk/57.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=geNkbcZ6qDo',
        title: 'Triseps Dips',
        subtitle:
            'Triceps Dips are an arm exercise that involve placing your hands on a bench or other elevated surface behind you, with your fingers pointing forward. Walk your feet out until your knees are at a 90-degree angle, then lower yourself down by bending your elbows. ',
        thumbUrl: 'assets/wk/thumbs/50.gif',
        imageUrl: 'assets/wk/50.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=L9IGOcrdcFk',
        title: 'Triceps Stretch Right',
        subtitle:
            'Triceps Stretch is a stretching exercise that targets the triceps muscles in your upper arms. Stand up straight and raise your right arm above your head, bending your elbow so that your right hand is behind your head.',
        thumbUrl: 'assets/wk/wkimgs/108.png',
        imageUrl: 'assets/wk/wkimgs/108.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=L9IGOcrdcFk',
        title: 'Triceps Stretch Left',
        subtitle:
            'Triceps Stretch is a stretching exercise that targets the triceps muscles in your upper arms. Stand up straight and raise your right arm above your head, bending your elbow so that your left hand is behind your head.',
        thumbUrl: 'assets/wk/wkimgs/91.png',
        imageUrl: 'assets/wk/wkimgs/91.png',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=jw8EXo5h0ec',
        title: 'Standing Bicep Stretch Left',
        subtitle:
            'The Standing Bicep Stretch is a stretching exercise that targets the bicep muscles in your upper arms. Stand up straight and interlock your fingers behind your back, with your palms facing upwards.',
        thumbUrl: 'assets/wk/wkimgs/109.png',
        imageUrl: 'assets/wk/wkimgs/109.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=jw8EXo5h0ec',
        title: 'Standing Bicep Stretch Right',
        subtitle:
            'The Standing Bicep Stretch is a stretching exercise that targets the bicep muscles in your upper arms. Stand up straight and interlock your fingers behind your back, with your palms facing upwards.',
        thumbUrl: 'assets/wk/wkimgs/107.png',
        imageUrl: 'assets/wk/wkimgs/107.png',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=rhtadqkrWo0',
        title: 'Elbow Back Stretch',
        subtitle:
            'The Elbow Back Stretch is a simple stretching exercise that targets the triceps muscle in the back of your upper arm.',
        thumbUrl: 'assets/wk/thumbs/58.gif',
        imageUrl: 'assets/wk/58.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=QGnz__47PCo',
        title: 'Plank taps',
        subtitle:
            'Plank taps is an exercise that targets your abs, arms and shoulders. Begin in a plank position with your arms straight and your body in a straight line from head to heels. ',
        thumbUrl: 'assets/wk/thumbs/60.gif',
        imageUrl: 'assets/wk/60.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=PqUi-H1edcE',
        title: 'Plank and Reach',
        subtitle:
            'Plank and reach is an exercise that targets your abs, back and shoulders. Begin in a plank position with your arms straight and your body in a straight line from head to heels.',
        thumbUrl: 'assets/wk/thumbs/61.gif',
        imageUrl: 'assets/wk/61.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=H8LoGZ-ZN48',
        title: 'Military Push Ups',
        subtitle:
            'military push-ups, involve starting in a plank position and then lowering your body down while keeping your elbows close to your sides.',
        thumbUrl: 'assets/wk/thumbs/58.gif',
        imageUrl: 'assets/wk/58.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=134v7cB-1W8',
        title: 'Doorway Curls Left',
        subtitle: 'Stand in a Doorway grasp the door frame using left hand',
        thumbUrl: 'assets/wk/thumbs/64.gif',
        imageUrl: 'assets/wk/64.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=134v7cB-1W8',
        title: 'Doorway Curls Right',
        subtitle: 'Stand in a Doorway grasp the door frame using right hand',
        thumbUrl: 'assets/wk/thumbs/65.gif',
        imageUrl: 'assets/wk/65.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Plv5CIclPtQ',
        title: 'Push Ups Rotation',
        subtitle:
            'Push-up rotations involve starting in a plank position and then lowering your body down while keeping your elbows close to your sides.',
        thumbUrl: 'assets/wk/thumbs/66.gif',
        imageUrl: 'assets/wk/66.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=3kZS8HVFquk',
        title: 'Leg Barbbel Curl Right',
        subtitle:
            'Lie on your stomach on a bench and keep your legs straight. Place the barbell at the end of your legs, hold it with your legs and curl your legs up,',
        thumbUrl: 'assets/wk/thumbs/68.gif',
        imageUrl: 'assets/wk/68.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=lUGi7NilqWA',
        title: 'Floor Raises',
        subtitle:
            'Floor raises are an exercise where you lie on the ground with your arms by your sides and lift your legs up toward the ceiling, keeping them straight.',
        thumbUrl: 'assets/wk/thumbs/69.gif',
        imageUrl: 'assets/wk/69.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=ZY2ji_Ho0dA',
        title: 'Inchworms',
        subtitle:
            'Stand straight with your feet hip-width apart and arms by your side. Bend over and touch the floor with your hands without bending your knees.',
        thumbUrl: 'assets/wk/thumbs/70.gif',
        imageUrl: 'assets/wk/70.gif',
      ),

      // add more exercises here
    ],
  ),

  ExerciseCategory(
    name: 'Butt',
    duration: '19:00',
    cal: '106',
    exercises: [
      Exercise(
        title: 'High stepping',
        subtitle:
            'Stand straight with your feet shoulder-width apart and your arms by your sides.Lift your right knee towards your chest, and then lower it back down to the floor.Repeat the same with your left knee.',
        thumbUrl: 'assets/wk/thumbs/13.gif',
        imageUrl: 'assets/wk/13.gif',
        videoUrl: 'https://youtu.be/Cmxr9xcNhgU',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=vXVPvY1UbJI',
        title: 'Butt Kicks',
        subtitle:
            'Butt Kicks is an exercise that involves rapidly kicking your feet towards your buttocks while moving forward. The aim is to kick your feet high enough to touch your buttocks.',
        thumbUrl: 'assets/wk/thumbs/7.gif',
        imageUrl: 'assets/wk/7.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=42bFodPahBU',
        title: 'Squats',
        subtitle:
            'Stand with your feet shoulder-width apart and your toes pointing slightly outward.Keeping your back straight and your chest up, bend your knees and lower your hips back and down as if youre sitting back into a chair.',
        thumbUrl: 'assets/wk/thumbs/8.gif',
        imageUrl: 'assets/wk/8.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=GucHQvB4Bbk',
        title: 'standing glute kickbacks right',
        subtitle:
            'to perform standing glute kickbacks on the right side, stand straight with your feet hip-width apart. Keep your hands on your hips or use a wall for support. ',
        thumbUrl: 'assets/wk/thumbs/9.gif',
        imageUrl: 'assets/wk/9.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=GucHQvB4Bbk',
        title: 'standing glute kickbacks Left',
        subtitle:
            'Stand with your feet shoulder-width apart and your arms at your sides.Shift your weight onto your left foot and slightly bend your left knee.',
        thumbUrl: 'assets/wk/thumbs/9.gif',
        imageUrl: 'assets/wk/9.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=6gGzYaD9Cb4',
        title: 'Butt Bridge',
        subtitle:
            'Butt Bridge is a glutes exercise that involves lying on your back with your knees bent and your feet flat on the ground, then lifting your hips up toward the ceiling. Squeeze your glutes at the top of the movement and lower your hips back down to the ground. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/10.gif',
        imageUrl: 'assets/wk/10.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=snSqy2pPEa4',
        title: 'Mountain Climber',
        subtitle:
            'Mountain Climber is a full-body exercise that involves getting into a plank position and bringing your knees to your chest, alternating legs. Keep your core engaged and perform the exercise at a quick pace. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/59.gif',
        imageUrl: 'assets/wk/59.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=pd3KyzQS5nc',
        title: 'Donkey Kicks Left',
        subtitle:
            'Start on all fours with your hands directly under your shoulders and your knees directly under your hips.Keeping your left knee bent, lift your left leg off the ground until your thigh is parallel to the floor.',
        thumbUrl: 'assets/wk/thumbs/11.gif',
        imageUrl: 'assets/wk/11.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=pd3KyzQS5nc',
        title: 'Donkey Kicks Right',
        subtitle:
            'Begin on all fours, with your hands shoulder-width apart and your knees hip-width apart.Keeping your right foot flexed and your knee bent, lift your right leg and press your foot up toward the ceiling until your thigh is parallel to the floor.',
        thumbUrl: 'assets/wk/wkimgs/99.png',
        imageUrl: 'assets/wk/wkimgs/99.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=3wthmvKWoOU',
        title: 'Kneeling Lunge Strech Left',
        subtitle:
            'Start in a kneeling position with your left leg forward and your right leg back.Place your hands on your left knee and press your hips forward until you feel a stretch in your left hip and thigh.',
        thumbUrl: 'assets/wk/wkimgs/98.png',
        imageUrl: 'assets/wk/wkimgs/98.png',
      ),
      Exercise(
          videoUrl: 'https://www.youtube.com/watch?v=3wthmvKWoOU',
          title: 'Kneeling Lunge Strech Right',
          subtitle:
              'In a kneeling position, take a large step forward with your right leg. Keep your right foot flat on the ground and extend your left leg behind you. ',
          thumbUrl: 'assets/wk/wkimgs/99.png',
          imageUrl: 'assets/wk/wkimgs/99.png'),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=1J8mVmtyYpk',
        title: 'Lunges',
        subtitle:
            'Lunges are a great exercise for the butt muscles. Stand with one foot forward and one foot back. Bend both knees and lower your body down until the back knee almost touches the floor.',
        thumbUrl: 'assets/wk/thumbs/35.gif',
        imageUrl: 'assets/wk/35.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Dm1GSX1vItY',
        title: 'Bottom Leg Lift Left',
        subtitle:
            'Bottom leg lift left: Lie on your side with your bottom arm extended and your head resting on it. Lift your bottom leg up as high as you can without moving your hips, then lower it back down.',
        thumbUrl: 'assets/wk/thumbs/15.gif',
        imageUrl: 'assets/wk/15.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Dm1GSX1vItY',
        title: 'Bottom Leg Lift right',
        subtitle:
            'Bottom leg lift right: Lie on your side with your bottom arm extended and your head resting on it. Lift your bottom leg up as high as you can without moving your hips, then lower it back down.',
        thumbUrl: 'assets/wk/thumbs/15.gif',
        imageUrl: 'assets/wk/15.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=7LnuhLi-78I',
        title: 'Fire Hudrant Right',
        subtitle:
            'Fire Hydrant Right: Start in a tabletop position with your hands under your shoulders and your knees under your hips.',
        thumbUrl: 'assets/wk/thumbs/18.gif',
        imageUrl: 'assets/wk/18.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=7LnuhLi-78I',
        title: 'Fire Hudrant Left',
        subtitle:
            'Fire Hydrant Left: Start in a tabletop position with your hands under your shoulders and your knees under your hips.',
        thumbUrl: 'assets/wk/thumbs/17.gif',
        imageUrl: 'assets/wk/17.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=SFSZVKzqnXA',
        title: 'Split Squat',
        subtitle:
            'Stand with one foot in front of the other, about two feet apart. Bend your front knee and lower your body until your thigh is parallel to the ground, then stand back up. Repeat on the other side.',
        thumbUrl: 'assets/wk/thumbs/20.gif',
        imageUrl: 'assets/wk/20.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=-rTyKlHjYT8',
        title: 'Curtsy Lunges',
        subtitle:
            'Start in a standing position with your feet hip-width apart. Take a step back and to the side with one foot, crossing it behind the other leg. Bend your knees and lower your body until your thigh is parallel to the ground, then stand back up. Repeat on the other side.',
        thumbUrl: 'assets/wk/thumbs/2.gif',
        imageUrl: 'assets/wk/2.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=4IsQwLnHkkk',
        title: 'Left Leg Knee',
        subtitle:
            'Start in a tabletop position with your hands under your shoulders and your knees under your hips. Lift your left knee off the ground and bring it in towards your chest, then extend it back out. Repeat on the other side.',
        thumbUrl: 'assets/wk/thumbs/22.gif',
        imageUrl: 'assets/wk/22.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=4IsQwLnHkkk',
        title: 'Right Leg Knee',
        subtitle:
            'Start in a tabletop position with your hands under your shoulders and your knees under your hips. Lift your right knee off the ground and bring it in towards your chest, then extend it back out. Repeat on the other side.',
        thumbUrl: 'assets/wk/thumbs/23.gif',
        imageUrl: 'assets/wk/23.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=9i0J_I4ASow',
        title: 'Flutter Kicks',
        subtitle:
            'Flutter Kicks is a lower abs exercise that involves lying on your back with your legs straight and lifting them a few inches off the ground. Then, alternate kicking your legs up and down in a fluttering motion, while keeping your core engaged and your back flat on the ground. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/24.gif',
        imageUrl: 'assets/wk/24.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Mi4H6YUVMCQ',
        title: 'Bench Glute Right',
        subtitle:
            'Sit on the edge of a bench with your feet flat on the ground. Place your hands on the bench behind you and lift your right leg up and back, squeezing your glutes at the top. Lower your leg and repeat on the other side.',
        thumbUrl: 'assets/wk/thumbs/25.gif',
        imageUrl: 'assets/wk/25.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Mi4H6YUVMCQ',
        title: 'Bench Glute Left',
        subtitle:
            'Sit on the edge of a bench with your feet flat on the ground. Place your hands on the bench behind you and lift your left leg up and back, squeezing your glutes at the top. Lower your leg and repeat on the other side.',
        thumbUrl: 'assets/wk/thumbs/26.gif',
        imageUrl: 'assets/wk/26.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=_pDhLWYEC18',
        title: 'Hip Bridge Left',
        subtitle:
            'Lie on your back with your knees bent and feet flat on the ground. Lift your hips up towards the ceiling, squeezing your glutes at the top. Lower your hips and repeat on the other side.',
        thumbUrl: 'assets/wk/wkimgs/s4.gif',
        imageUrl: 'assets/wk/wkimgs/s4.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=_pDhLWYEC18',
        title: 'Hip Bridge Right',
        subtitle:
            'Lie on your back with your knees bent and feet flat on the ground. Lift your hips up towards the ceiling, squeezing your glutes at the top. Lower your hips and repeat on the other side.',
        thumbUrl: 'assets/wk/wkimgs/s3.gif',
        imageUrl: 'assets/wk/wkimgs/s3.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=txLE-jOCEsc',
        title: 'Jumping Squats',
        subtitle:
            'Stand with your feet shoulder-width apart. Squat down and then jump up explosively, landing back in the squat position. Repeat.',
        thumbUrl: 'assets/wk/thumbs/1.gif',
        imageUrl: 'assets/wk/1.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=9rme1RyAJEE',
        title: 'Sumo Squat',
        subtitle:
            'Stand with your feet wider than shoulder-width apart, toes pointing outwards. Squat down, keeping your knees over your toes, then stand back up. Repeat.',
        thumbUrl: 'assets/wk/thumbs/34.gif',
        imageUrl: 'assets/wk/34.gif',
      ),
    ],
  ),

  ExerciseCategory(
    name: 'Thigh',
    duration: '19:00',
    cal: '128',
    exercises: [
      Exercise(
        title: 'Jumping Jacks',
        subtitle:
            'Stand up straight with your feet together and your arms at your sides. Jump up and spread your feet apart while raising your arms above your head. Land on the balls of your feet and keep your knees slightly bent. Jump again and bring your feet back together while lowering your arms to your sides. Repeat the exercise for the desired number of repetitions',
        thumbUrl: 'assets/wk/thumbs/33.gif',
        imageUrl: 'assets/wk/33.gif',
        videoUrl: 'https://www.youtube.com/watch?v=2W4ZNSwoW_4',
      ),
      Exercise(
        title: 'High Stepping',
        subtitle:
            'High Stepping is a cardio exercise that involves lifting your knees as high as you can while stepping in place. Swing your arms naturally and maintain a quick pace. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/13.gif',
        imageUrl: 'assets/wk/13.gif',
        videoUrl: 'https://youtu.be/Cmxr9xcNhgU',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=42bFodPahBU',
        title: 'Squats',
        subtitle:
            'Stand with your feet shoulder-width apart and your toes pointing slightly outward.Keeping your back straight and your chest up, bend your knees and lower your hips back and down as if youre sitting back into a chair.',
        thumbUrl: 'assets/wk/thumbs/8.gif',
        imageUrl: 'assets/wk/8.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=pd3KyzQS5nc',
        title: 'Donkey Kicks Left',
        subtitle:
            'Start on all fours with your hands directly under your shoulders and your knees directly under your hips.Keeping your left knee bent, lift your left leg off the ground until your thigh is parallel to the floor.',
        thumbUrl: 'assets/wk/thumbs/11.gif',
        imageUrl: 'assets/wk/11.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=pd3KyzQS5nc',
        title: 'Donkey Kicks Right',
        subtitle:
            'Begin on all fours, with your hands shoulder-width apart and your knees hip-width apart.Keeping your right foot flexed and your knee bent, lift your right leg and press your foot up toward the ceiling until your thigh is parallel to the floor.',
        thumbUrl: 'assets/wk/wkimgs/99.png',
        imageUrl: 'assets/wk/wkimgs/99.png',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=8PbnMQISmZQ',
        title: 'Modiefied Burpees',
        subtitle:
            'Begin in a standing position with your feet shoulder-width apart. Lower your body into a squatting position, placing your hands on the floor in front of you. Jump your feet back into a plank position. Jump your feet forward, landing back into the squat position. Finally, jump up with your arms overhead',
        thumbUrl: 'assets/wk/thumbs/70.gif',
        imageUrl: 'assets/wk/70.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=_LGpDtENZ5U',
        title: 'Backward Lunge',
        subtitle:
            'Begin standing tall. Step back with one leg, lowering your hips until both knees are bent at a 90-degree angle. Make sure your front knee is directly above your ankle and not pushed out too far. Return to standing by pushing through your front leg. Repeat on the other side.',
        thumbUrl: 'assets/wk/thumbs/30.gif',
        imageUrl: 'assets/wk/30.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=WFtPk4Z-k60',
        title: 'Left Quad Wall',
        subtitle:
            'Stand about 2 to 3 feet away from a wall, facing the wall. Raise one foot and rest it against the wall, keeping your heel on the ground. Slowly lean forward, bending the front knee, until you feel a stretch in your hip and thigh. Hold for 30 seconds. Repeat on the other side.',
        thumbUrl: 'assets/wk/wkimgs/88.png',
        imageUrl: 'assets/wk/wkimgs/88.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=WFtPk4Z-k60',
        title: 'Right Quad Wall',
        subtitle:
            'Stand about 2 to 3 feet away from a wall, facing the wall. Raise one foot and rest it against the wall, keeping your heel on the ground. Slowly lean forward, bending the front knee, until you feel a stretch in your hip and thigh. Hold for 30 seconds. Repeat on the other side.',
        thumbUrl: 'assets/wk/wkimgs/89.png',
        imageUrl: 'assets/wk/wkimgs/89.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=bJms9YyjoBI',
        title: 'Knee To Chest Left',
        subtitle:
            'Lie on your back with your knees bent and your feet flat on the floor. Bring one knee to your chest, keeping the other foot on the ground. Hold for 30 seconds. Repeat on the other side.',
        thumbUrl: 'assets/wk/wkimgs/102.png',
        imageUrl: 'assets/wk/wkimgs/102.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=bJms9YyjoBI',
        title: 'Knee To Chest Left',
        subtitle:
            'Lie on your back with your knees bent and your feet flat on the floor. Bring one knee to your chest, keeping the other foot on the ground. Hold for 30 seconds. Repeat on the other side.',
        thumbUrl: 'assets/wk/wkimgs/103.png',
        imageUrl: 'assets/wk/wkimgs/103.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=nYmUEJIBj3c',
        title: 'Side Hop',
        subtitle:
            'Stand with your feet shoulder-width apart. Hop to the side, landing on the opposite foot. Alternate sides, jumping back and forth. Move as quickly as possible, landing softly on your feet with each jump.',
        thumbUrl: 'assets/wk/thumbs/34.gif',
        imageUrl: 'assets/wk/34.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=JvA7t9xKWgg',
        title: 'Frog Press',
        subtitle:
            'Lie on your back with your feet together and your knees bent out to the sides, creating a diamond shape with your legs. Bring the soles of your feet together and let your knees fall open. ',
        thumbUrl: 'assets/wk/thumbs/36.gif',
        imageUrl: 'assets/wk/36.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=7LnuhLi-78I',
        title: 'Fire Hudrant Right',
        subtitle:
            'Begin on all fours, hands directly under shoulders and knees under hips. Keep your back straight and your head in line with your spine. Raise your right leg up and out to the side, keeping your knee bent and your foot flexed. Lower your leg back to starting position and repeat.',
        thumbUrl: 'assets/wk/thumbs/18.gif',
        imageUrl: 'assets/wk/18.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=7LnuhLi-78I',
        title: 'Fire Hudrant Left',
        subtitle:
            'Begin on all fours, hands directly under shoulders and knees under hips. Keep your back straight and your head in line with your spine. Raise your left leg up and out to the side, keeping your knee bent and your foot flexed. Lower your leg back to starting position and repeat.',
        thumbUrl: 'assets/wk/thumbs/17.gif',
        imageUrl: 'assets/wk/17.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=VlwBJE1WtOQ',
        title: 'Side Lying Leg right',
        subtitle:
            'Lie on your right side with your legs extended and your feet and hips resting on the floor. Place your right arm under your head and use your left arm to support your body. Raise your left leg as high as you can without moving your pelvis. Lower your leg and repeat.',
        thumbUrl: 'assets/wk/thumbs/31.gif',
        imageUrl: 'assets/wk/31.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=VlwBJE1WtOQ',
        title: 'Side Lying Leg left',
        subtitle:
            'Lie on your left side with your legs extended and your feet and hips resting on the floor. Place your left arm under your head and use your right arm to support your body. Raise your right leg as high as you can without moving your pelvis. Lower your leg and repeat.',
        thumbUrl: 'assets/wk/thumbs/42.gif',
        imageUrl: 'assets/wk/42.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=1J8mVmtyYpk',
        title: 'Lungs',
        subtitle:
            'Begin standing with your feet shoulder-width apart. Step forward with one leg and lower your body until your knee is at a 90-degree angle. Keep your front knee directly above your ankle and your back knee off the ground. Push through your front heel to return to standing position and repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/21.gif',
        imageUrl: 'assets/wk/21.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=9rme1RyAJEE',
        title: 'Sumo Squat',
        subtitle:
            'A lower body exercise that targets your quads, glutes, hamstrings, and inner thighs',
        thumbUrl: 'assets/wk/thumbs/34.gif',
        imageUrl: 'assets/wk/34.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=bJms9YyjoBI',
        title: 'Knee To Chest Right',
        subtitle: 'Strengthens and stretches your hips, lower back, and legs',
        thumbUrl: 'assets/wk/wkimgs/102.png',
        imageUrl: 'assets/wk/wkimgs/102.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=bJms9YyjoBI',
        title: 'Knee To Chest Left',
        subtitle: 'Strengthens and stretches your hips, lower back, and legs',
        thumbUrl: 'assets/wk/wkimgs/103.png',
        imageUrl: 'assets/wk/wkimgs/103.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Dm1GSX1vItY',
        title: 'Bottom Leg Lift Left',
        subtitle:
            'Lie on your back with both legs bent and feet flat on the ground. Lift one leg up, keeping the knee bent, and slowly lower it back down. Repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/16.gif',
        imageUrl: 'assets/wk/16.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Dm1GSX1vItY',
        title: 'Bottom Leg Lift Right',
        subtitle:
            'Lie on your back with both legs bent and feet flat on the ground. Lift one leg up, keeping the knee bent, and slowly lower it back down. Repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/15.gif',
        imageUrl: 'assets/wk/15.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=e25jpcjeyAQ',
        title: 'Glute Kick Right',
        subtitle:
            'Get on all fours with your hands under your shoulders and knees under your hips. Lift one leg up, keeping the knee bent, and kick back. Return to the starting position and repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/27.gif',
        imageUrl: 'assets/wk/27.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=e25jpcjeyAQ',
        title: 'Glute Kick Left',
        subtitle:
            'Get on all fours with your hands under your shoulders and knees under your hips. Lift one leg up, keeping the knee bent, and kick back. Return to the starting position and repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/28.gif',
        imageUrl: 'assets/wk/28.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=tlUg1DXhHm8',
        title: 'Side Lunges',
        subtitle:
            'Stand with your feet shoulder-width apart. Step to the side with one foot, bending the knee and keeping the other leg straight. Return to the starting position and repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/2.gif',
        imageUrl: 'assets/wk/2.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=NJ4JEAEIqvU',
        title: 'Leg circle Right',
        subtitle:
            'Lie on your side with your legs straight. Lift one leg up, keeping it straight, and circle it around in front of you. Return to the starting position and repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/31.gif',
        imageUrl: 'assets/wk/31.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=NJ4JEAEIqvU',
        title: 'Leg circle Left',
        subtitle:
            'Lie on your side with your legs straight. Lift one leg up, keeping it straight, and circle it around in front of you. Return to the starting position and repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/42.gif',
        imageUrl: 'assets/wk/42.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=Yp3ZwACK9v4',
        title: 'Wall Sit',
        subtitle:
            'Stand with your back against a wall and slide down until your thighs are parallel to the ground. Hold this position for as long as you can.',
        thumbUrl: 'assets/wk/wkimgs/83.png',
        imageUrl: 'assets/wk/wkimgs/83.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=WFtPk4Z-k60',
        title: 'Left Quad Wall',
        subtitle:
            'Stand with your left side against a wall and place your left foot on the wall. Slowly slide down until your left thigh is parallel to the ground. Hold this position for as long as you can and repeat on the other leg.',
        thumbUrl: 'assets/wk/wkimgs/89.png',
        imageUrl: 'assets/wk/wkimgs/89.png',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=WFtPk4Z-k60',
        title: 'Right Quad Wall',
        subtitle:
            'Stand with your right side against a wall and place your right',
        thumbUrl: 'assets/wk/wkimgs/88.png',
        imageUrl: 'assets/wk/wkimgs/88.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=bzfY0Zr3sUE',
        title: 'Lyin Butterfly',
        subtitle:
            'A relaxing pose that stretches your hips, thighs, and lower back while reducing stress',
        thumbUrl: 'assets/wk/wkimgs/95.png',
        imageUrl: 'assets/wk/wkimgs/95.png',
      ),
      // add more exercises here
    ],
  ),

  ExerciseCategory(
    name: 'Stretching',
    duration: '05:00',
    cal: '167',
    exercises: [
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=-KKADnBsPzw',
        title: 'Bridge',
        subtitle:
            'An effective exercise that strengthens your lower back, glutes, and hamstrings',
        thumbUrl: 'assets/wk/wkimgs/84.png',
        imageUrl: 'assets/wk/wkimgs/84.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=dV8ll1vnle0',
        title: 'Reverse Crunches',
        subtitle:
            'Reverse Crunches is a lower abs exercise that involves lying on your back with your legs bent and your feet flat on the ground. Lift your hips off the ground and bring your knees toward your chest, then lower them back down to the starting position. Keep your core engaged and your back flat on the ground throughout the exercise. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/3.gif',
        imageUrl: 'assets/wk/3.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=RUNrHkbP4Pc',
        title: 'Abdominal Crunches',
        subtitle:
            'A core exercise that targets your abdominal muscles for a toned midsection',
        thumbUrl: 'assets/wk/thumbs/63.gif',
        imageUrl: 'assets/wk/63.gif',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=6gGzYaD9Cb4',
        title: 'Butt Bridge',
        subtitle:
            'Butt Bridge is a glutes exercise that involves lying on your back with your knees bent and your feet flat on the ground, then lifting your hips up toward the ceiling. Squeeze your glutes at the top of the movement and lower your hips back down to the ground. Repeat for the desired number of repetitions.',
        thumbUrl: 'assets/wk/thumbs/10.gif',
        imageUrl: 'assets/wk/10.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=9A7ZAXxMV0Q',
        title: 'Plank',
        subtitle:
            'Plank is a full-body exercise that involves holding a straight line from your head to your heels while balancing on your forearms and toes. Keep your core engaged and your back flat throughout the exercise. Hold the position for the desired amount of time.',
        thumbUrl: 'assets/wk/wkimgs/106.png',
        imageUrl: 'assets/wk/wkimgs/106.png',
      ),
      Exercise(
          videoUrl: 'https://www.youtube.com/watch?v=-WUqsBbFddI',
          title: 'Bird Dog',
          subtitle:
              'A stability exercise that strengthens your lower back, glutes, and core',
          thumbUrl: 'assets/wk/thumbs/4.gif',
          imageUrl: 'assets/wk/4.gif'),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=z21McHHOpAg',
        title: 'Cobra Stretch',
        subtitle:
            'Cobra Stretch is a back stretch exercise that involves lying on your stomach with your hands on the ground under your shoulders. Push your chest up and arch your back, keeping your elbows close to your sides. Hold the position for the desired amount of time.',
        thumbUrl: 'assets/wk/wkimgs/86.png',
        imageUrl: 'assets/wk/wkimgs/86.png',
      ),

      Exercise(
          videoUrl: 'https://www.youtube.com/watch?v=1McKjXfOIJ4',
          title: 'Shoulder Stretching',
          subtitle:
              'An upper body stretch that releases tension in your shoulders and neck',
          thumbUrl: 'assets/wk/thumbs/5.gif',
          imageUrl: 'assets/wk/5.gif'),
      Exercise(
          videoUrl: 'https://www.youtube.com/watch?v=vXVPvY1UbJI',
          title: 'Butt Kicks',
          subtitle:
              'A cardio exercise that strengthens your glutes and hamstrings',
          thumbUrl: 'assets/wk/thumbs/7.gif',
          imageUrl: 'assets/wk/7.gif'),

      Exercise(
        title: 'Jumping Jacks',
        subtitle:
            'Stand up straight with your feet together and your arms at your sides. Jump up and spread your feet apart while raising your arms above your head. Land on the balls of your feet and keep your knees slightly bent. Jump again and bring your feet back together while lowering your arms to your sides. Repeat the exercise for the desired number of repetitions',
        thumbUrl: 'assets/wk/thumbs/33.gif',
        imageUrl: 'assets/wk/33.gif',
        videoUrl: 'https://www.youtube.com/watch?v=2W4ZNSwoW_4',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=WFtPk4Z-k60',
        title: 'Left Quad Wall',
        subtitle:
            'Stand with your left leg in front of your right leg and lean your left foot against a wall. Slowly bend your left leg and move your hips towards the wall until you feel a stretch in your right quad. Hold for 30 seconds and repeat on the other leg.',
        thumbUrl: 'assets/wk/wkimgs/88.png',
        imageUrl: 'assets/wk/wkimgs/88.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=WFtPk4Z-k60',
        title: 'Right Quad Wall',
        subtitle:
            'Stand with your right leg in front of your left leg and lean your right foot against a wall. Slowly bend your right leg and move your hips towards the wall until you feel a stretch in your left quad. Hold for 30 seconds and repeat on the other leg.',
        thumbUrl: 'assets/wk/wkimgs/87.png',
        imageUrl: 'assets/wk/wkimgs/87.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=mJOGKTYUAzY',
        title: 'Calf Stretching',
        subtitle:
            'Stand facing a wall with your hands resting against it. Step one foot back and press your heel to the floor while keeping your knee straight. Hold for 30 seconds and repeat on the other leg.',
        thumbUrl: 'assets/wk/thumbs/13.gif',
        imageUrl: 'assets/wk/2.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=L9IGOcrdcFk',
        title: 'Triceps Stretch Right',
        subtitle:
            'Triceps Stretch is a stretching exercise that targets the triceps muscles in your upper arms. Stand up straight and raise your right arm above your head, bending your elbow so that your right hand is behind your head.',
        thumbUrl: 'assets/wk/wkimgs/108.png',
        imageUrl: 'assets/wk/wkimgs/108.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=L9IGOcrdcFk',
        title: 'Triceps Stretch Left',
        subtitle:
            'Triceps Stretch is a stretching exercise that targets the triceps muscles in your upper arms. Stand up straight and raise your right arm above your head, bending your elbow so that your left hand is behind your head.',
        thumbUrl: 'assets/wk/wkimgs/91.png',
        imageUrl: 'assets/wk/wkimgs/91.png',
      ),

      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=DMwRPGMPB10',
        title: 'Child Pose',
        subtitle:
            'Kneel on the floor with your big toes touching and your knees separated widely.',
        thumbUrl: 'assets/wk/thumbs/9.gif',
        imageUrl: 'assets/wk/9.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=w_UKcI1Ftn8',
        title: 'Cat Cow Pose',
        subtitle:
            'Start with your hands and knees on the floor in a tabletop position.',
        thumbUrl: 'assets/wk/thumbs/6.gif',
        imageUrl: 'assets/wk/6.gif',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=ZI-j_POtzlU',
        title: 'Lying Twist Right',
        subtitle:
            'Lie on your back with your arms extended out to the sides and your palms facing down.',
        thumbUrl: 'assets/wk/wkimgs/96.png',
        imageUrl: 'assets/wk/wkimgs/96.png',
      ),
      Exercise(
        videoUrl: 'https://www.youtube.com/watch?v=ZI-j_POtzlU',
        title: 'Lying Twist Left',
        subtitle:
            'Lie on your back with your knees bent and your feet on the ground.',
        thumbUrl: 'assets/wk/wkimgs/97.png',
        imageUrl: 'assets/wk/wkimgs/97.png',
      ),
      // add more exercises here
    ],
  ),
  // add more categories here
];
