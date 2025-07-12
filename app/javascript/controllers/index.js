import { application } from "./application"

// Import your hello controller
import HelloController from "./hello_controller"

// Register it with a name
application.register("hello", HelloController)
