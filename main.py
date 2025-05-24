from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.button import Button
from kivy.uix.label import Label

class MyLayout(BoxLayout):
    def __init__(self, **kwargs):
        super(MyLayout, self).__init__(**kwargs)
        self.orientation = 'vertical'

        self.label = Label(text="Click the button below")
        self.add_widget(self.label)

        self.button = Button(text="Click Me!")
        self.button.bind(on_press=self.say_hello)
        self.add_widget(self.button)

    def say_hello(self, instance):
        self.label.text = "Hello World"

class MyApp(App):
    def build(self):
        return MyLayout()

if __name__ == "__main__":
    MyApp().run()
