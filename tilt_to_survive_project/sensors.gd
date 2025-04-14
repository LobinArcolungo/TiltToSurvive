extends Node

var JavaScript = JavaScriptBridge
func get_permission():
	
	if !OS.has_feature('web'): pass
	JavaScript.eval("""
		var acceleration = { x: 0, y: 0, z: 0 }

		function registerMotionListener() {
		//	window.ondevicemotion = function(event) {
		//		 if (event.acceleration.x === null) return
		//		 acceleration.x = event.acceleration.x
		//		 acceleration.y = event.acceleration.y
		//		 acceleration.z = event.acceleration.z
		//	}
			window.ondeviceorientation = function(event) {
				if (event.alpha === null) return
				acceleration.x = event.alpha
				acceleration.y = event.beta
				acceleration.z = event.gamma 
			}
		}

		if (typeof DeviceOrientationEvent.requestPermission === 'function') {
			DeviceOrientationEvent.requestPermission().then(function(state) {
				if (state === 'granted') registerMotionListener()
			})
		}
		else {
			registerMotionListener()
		}
	""", true)

#	JavaScript.eval("""
#	function permission () {
#		
#			if ( typeof( DeviceMotionEvent ) !== "undefined" && typeof( DeviceMotionEvent.requestPermission ) === "function" ) {
#				// (optional) Do something before API request prompt.
#				DeviceMotionEvent.requestPermission()
#					.then( response => {
#					// (optional) Do something after API prompt dismissed.
#					if ( response == "granted" ) {
#						window.addEventListener( "devicemotion", (e) => {
#							// do something for 'e' here.
#						})
#					}
#				})
#					.catch( console.error )
#			} else {
#				alert( "DeviceMotionEvent is not defined" );
#			}
#		}
#		permission();
#	""",true)
func get_accelerometer() -> Vector3:
	if !OS.has_feature('web'): return Input.get_accelerometer()
	
	#if OS.has_feature('web_ios'): 
	#	return Vector3(x, y, z)
	
	var x = JavaScript.eval('acceleration.x')
	var y = JavaScript.eval('acceleration.y')
	var z = JavaScript.eval('acceleration.z')
	return Vector3(x, y, z)
