import React from 'react'
import { StyleSheet, Text, View, Button } from 'react-native'

export default class App extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      isLoading: true
    }
  }

  async fetchShow () {
    try {
      let headers = {
        'Content-Type': 'application/json',
        'trakt-api-version': '2',
        'trakt-api-key': 'dc60acabe3d5d953393a0e332d8d7d3c5e3c7b7710158b5223526e79f1cf597a'
      }
      let response = await fetch(
        'https://api-staging.trakt.tv/shows/game-of-thrones?extended=full', headers
      )
      let responseJson = await response.json()
      console.log(responseJson.show)
      return responseJson.show
    } catch (error) {
      console.error(error)
    }
  }

  render () {
    return (
      <View style={styles.container}>
        {/* <Text>Open App.js to start working on your app!</Text> */}
        <Text>Changes you make will automatically reload.</Text>
        <Text >Shake your phone to open the developer menu.</Text>
        <Button>onPress={this.fetchShow.bing(this) }</Button>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center'
  }
})
