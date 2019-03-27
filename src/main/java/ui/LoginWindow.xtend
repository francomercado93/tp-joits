package ui

import appModel.CompraTicket
import appModel.LoginUsuario
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.windows.ErrorsPanel

class LoginWindow extends SimpleWindow<LoginUsuario> {

	new(WindowOwner parent) {
		super(parent, new LoginUsuario)
		title = "Login Joits"
		taskDescription = "Ingrese usuario y contraseña!!!"
	}

	override ErrorsPanel createErrorsPanel(Panel mainPanel) {
		// Al pedo, para usarlo como label ya que está.
		new ErrorsPanel(mainPanel, "Ingrese usuario y contraseña!!")
	}

	override protected createFormPanel(Panel mainPanel) {

		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			new Label(it) => [
				text = "Usuario"
			]

			new TextBox(it) => [
				value <=> "usrname"
			]

			new Label(it) => [
				text = "Password"
			]

			new PasswordField(it) => [
				value <=> "pass"
			]
		]
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Aceptar"
			// Pa la tecla enter.
			setAsDefault
			onClick [|
				// Si validarUsuario devuelve algo --> goto pantalla menu y sino mostramos un MessageBox.
				if (modelObject.validarUsuario !== null) {
					new CompraTicketSimpleWindow(this, new CompraTicket(modelObject.usuarioSeleccionado)).open
					this.close
				} else {
					showInfo("Login incorrecto!")
				}
			]
		]

		new Button(actionsPanel) => [
			caption = "Cancelar"
			onClick [
				this.close
			]
		]
	}

}
