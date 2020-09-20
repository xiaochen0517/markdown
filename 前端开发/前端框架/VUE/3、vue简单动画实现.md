# `vue`简单动画实现

- `html`

```html
<button @click="show =! show">show</button>
<transition name="fade">
	<h1 v-show="show">动画</h1>
</transition>
```

- `js`

```js
data () {
    return {
      show: true
    }
}
```

- `css`

```css
.fade-enter-active, .fade-leave-active {
  transition: all 1s ease;
}
.fade-enter, .fade-leave-to {
  transform: translateX(20px);
  opacity: 0;
}
```

