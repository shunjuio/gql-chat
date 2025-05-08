import * as ActionCable from '@rails/actioncable'

const consumer = ActionCable.createConsumer('/cable')
export default consumer
