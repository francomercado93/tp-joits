package ui

import appModel.LoginUsuario
import domain.Usuario
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class LoginWindow extends SimpleWindow<LoginUsuario> {

	new(WindowOwner parent) {
		super(parent, new LoginUsuario)
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Aceptar"
//			setAsDefault
//			enabled <=> "validarUsuario"
			onClick [|
//				val usuarioSeleccionado = this.modelObject.usuarioSeleccionado
				new CompraEntradasWindow(this, new Usuario("MarioSantos", "milazzo")).open
			]
//			disableOnError
		]

		new Button(actionsPanel) => [
			caption = "Cancelar"
			onClick[|this.close]
		]
	}

	override protected createFormPanel(Panel mainPanel) {

		this.title = "Joits - Login"
		new ErrorsPanel(mainPanel, "Ingrese usuario y contraseña")
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			new Label(it) => [
				text = "Usuario:"
			]

			new TextBox(it) => [
				value <=> "usrname"
			]

			new Label(it) => [
				text = "Password:"
			]

			new PasswordField(it) => [
				value <=> "pass"
			]
		]
	}

}
