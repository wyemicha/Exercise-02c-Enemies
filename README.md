# Exercise-02c-Enemies

Exercise for MSCH-C220, 10 February 2021

A demonstration of this exercise is available at [https://youtu.be/TOXMqhFiYqw](https://youtu.be/TOXMqhFiYqw)

This exercise should provide an important step toward being able to implement Project 02. We will be creating enemies that periodically shoot and move according to a preset pattern.

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-02c-Enemies. *Edit the LICENSE and replace BL-MSCH-C220-S21 with your full name.* Commit your changes.

Press the green "Code" button and select "Open in GitHub Desktop". Allow the browser to open (or install) GitHub Desktop. Once GitHub Desktop has loaded, you should see a window labeled "Clone a Repository" asking you for a Local Path on your computer where the project should be copied. Choose a location; make sure the Local Path ends with "Exercise-02c-Enemies" and then press the "Clone" button. GitHub Desktop will now download a copy of the repository to the location you indicated.

Open Godot. In the Project Manager, tap the "Import" button. Tap "Browse" and navigate to the repository folder. Select the project.godot file and tap "Open".

This exercise will involve creating a new Enemy scene and then instancing that inside the Game scene.

Create a new scene (Scene->New Scene). Create a Root Node->Other Node->KinematicBody2D. Name the new KinematicBody2D node "Enemy".

Right-click on the Enemy node and Add Child Node. Choose Sprite. Select the sprite; drag Enemy/Enemy1.png from the FileSystem panel to the Texture property in the Inspector node.

Then, in the Toolbar, select the Sprite menu. Select CreateCollisionPolygon2D Sibling.

Right-click on the Enemy node and Add Child Node. Choose Tween.

Right-click on the Enemy node and Add Child Node. Choose Timer. Rename the Timer node "Move".

Select the Move node. In the Inspector Panel, set the Wait Time to 10. Set Autostart to On.

Right-click on the Enemy node and Add Child Node. Choose Timer. Rename the Timer node "Shoot".

Select the Shoot node. In the Inspector Panel, set the Wait Time to 3. Set Autostart to On.

Right-click on the Enemy node and Attach Script. The path to the new script should be res://Enemy/Enemy.gd.

Replace the contents of Enemy.gd with the following:

```
extends KinematicBody2D

var Bullet = load("res://Bullet/Bullet.tscn")
onready var Bullets = get_node("/root/Game/Bullets")

var move_speed = 3

var p = 0
var positions = [
	Vector2(100,100),
	Vector2(924,100),
	Vector2(924,400),
	Vector2(100,400),
]
var offset = Vector2.ZERO

func _ready():
	offset = position
	position = positions[0] + offset
	p = 1
```

Be careful to ensure that the resulting code is inserted with tabs instead of spaces.

In the Scene panel, select the Move node, and then go to the Node panel (next to the Inspector). In Signals->Timer, select timeout(). Connect to the "Enemy" node and then press the Connect button.

This will create a new function in Enemy.gd called `func _on_Move_timeout()`. The contents of the function should be as follows:
```
func _on_Move_timeout():
	$Tween.interpolate_property(self, "position", position, positions[p] + offset, move_speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	p = wrapi(p+1, 0, len(positions))

```
(ensure that you are using tabs instead of spaces).

Repeat that process with the Shoot node. In that case, the new function should be as follows:
```
func _on_Shoot_timeout():
	var bullet = Bullet.instance()
	bullet.position = position + Vector2(0,30)
	Bullets.add_child(bullet)

```

Save the scene as res://Enemy/Enemy.tscn

Go back to the Game Scene. Right-click on the Enemies node and choose Instance Child Scene. Choose Enemy/Enemy.tscn.

Repeat this two more times, until you have Enemy, Enemy2, and Enemy3 as children of Enemies.

Select Enemy2. In the Inspector Panel->Node2D->Transform, set the Position to x = 100, y = 100.

Select Enemy3. In the Inspector Panel->Node2D->Transform, set the Position to x = -100, y = 100.

Run the scene. You should now see three enemies moving in formation and periodically firing lasers.

Quit Godot. In GitHub desktop, you should now see the updated files listed in the left panel. In the bottom of that panel, type a Summary message (something like "Completes the exercise") and press the "Commit to master" button. On the right side of the top, black panel, you should see a button labeled "Push origin". Press that now.

If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-02c-Enemies) on Canvas.

The final state of the file should be as follows (replacing my information with yours):
```
# Exercise-02c-Enemies
Exercise for MSCH-C220, 10 February 2021

A simple demonstration of enemies that follow a pattern and shoot.

## To play
Just observe

## Implementation
Built using Godot 3.2.2

## References
None

## Future Development
None

## Created by 
Jason Francis

```
