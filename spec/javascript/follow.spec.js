import { mount, shallowMount } from '@vue/test-utils'
import Follow from '../../app/javascript/vue/follow.vue'
import 'jest'
import flushPromises from 'flush-promises'

jest.mock('axios', () => ({
  _esModule: true,
  default: jest.fn(() => Promise.resolve({ data: false })),
  get: jest.fn(() => Promise.resolve({ data: false })),
  post: jest.fn(() => Promise.resolve({ data: true }))
}))

const MockFn = jest
  .fn()
  .mockReturnValue({ data: true })
  .mockReturnValueOnce({ data: true })
  .mockReturnValueOnce({ data: false })

describe("FollowComponent", () => {
  const wrapper = mount(Follow)
  wrapper.find("button").trigger("click")
  test("follow channel", async() => {
    MockFn
    await flushPromises()
    const followButton = wrapper.find("i")
    expect(followButton.text()).toContain("フォロー解除")
  }),
  test("unfollow channel", async() => {
    MockFn
    await flushPromises()
    const followButton = wrapper.find("i")
    expect(followButton.text()).toContain("フォロー")
  })
})
